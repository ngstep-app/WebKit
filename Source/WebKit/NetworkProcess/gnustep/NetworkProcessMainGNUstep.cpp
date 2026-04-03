#include "config.h"
#include "NetworkProcessMain.h"
#include "AuxiliaryProcessMain.h"

int main(int argc, char** argv)
{
    return WebKit::AuxiliaryProcessMain<WebKit::NetworkProcessMain>(argc, argv);
}
