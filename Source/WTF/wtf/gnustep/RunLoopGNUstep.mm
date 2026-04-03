/*
 * Copyright (C) 2026 Gershwin Project Authors. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// Based on wtf/win/RunLoopWin.cpp - Win32 message loop -> NSRunLoop + dispatch

#include "config.h"
#include <wtf/RunLoop.h>

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

namespace WTF {

void RunLoop::run()
{
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] run];
    }
}

void RunLoop::stop()
{
    CFRunLoopStop([[NSRunLoop currentRunLoop] getCFRunLoop]);
}

RunLoop::RunLoop()
{
}

RunLoop::~RunLoop()
{
    Locker locker { m_loopLock };
    m_liveTimers.clear();
}

void RunLoop::wakeUp()
{
    Ref protectedThis { *this };
    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool {
            protectedThis->performWork();
        }
    });
}

RunLoop::CycleResult RunLoop::cycle(RunLoopMode)
{
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    return CycleResult::Continue;
}

// Timer implementation using dispatch_source
void RunLoop::TimerBase::start(Seconds interval, bool repeat)
{
    Locker locker { m_runLoop->m_loopLock };
    m_runLoop->m_liveTimers.add(std::bit_cast<uintptr_t>(this));

    Ref protectedRunLoop { *m_runLoop };
    RunLoop::TimerBase* timer = this;
    bool shouldRepeat = repeat;
    Seconds fireInterval = interval;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval.seconds() * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
            @autoreleasepool {
                Locker locker { protectedRunLoop->m_loopLock };
                if (!protectedRunLoop->m_liveTimers.contains(std::bit_cast<uintptr_t>(timer)))
                    return;
                locker.unlockEarly();
                timer->timerFired();
                if (shouldRepeat)
                    timer->start(fireInterval, true);
            }
        });
}

void RunLoop::TimerBase::stop()
{
    Locker locker { m_runLoop->m_loopLock };
    m_runLoop->m_liveTimers.remove(std::bit_cast<uintptr_t>(this));
}

bool RunLoop::TimerBase::isActive() const
{
    Locker locker { m_runLoop->m_loopLock };
    return m_runLoop->m_liveTimers.contains(std::bit_cast<uintptr_t>(this));
}

Seconds RunLoop::TimerBase::secondsUntilFire() const
{
    return Seconds(0);
}

} // namespace WTF
