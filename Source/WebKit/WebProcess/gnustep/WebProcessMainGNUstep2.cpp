#include "config.h"
#include "WebProcessMain.h"
#include "AuxiliaryProcessMain.h"

int main(int argc, char** argv)
{
    return WebKit::AuxiliaryProcessMain<WebKit::WebProcessMain>(argc, argv);
}
