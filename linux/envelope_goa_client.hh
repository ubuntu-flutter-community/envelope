#include <functional>
#include <goa/goa.h>

class EnvelopeGoaClient {
    std::function<void(EnvelopeGoaClient)> onCreate;

    void handleGoaClient(Goa)

    EnvelopeGoaClient(decltype(onCreate) cb) {
        
    }
}