#include <functional>
#include <memory>
#define GOA_API_IS_SUBJECT_TO_CHANGE
#include <goa/goa.h>

class EnvelopeGoaClient {
    std::function<void(EnvelopeGoaClient&)> _onCreate;
    GoaClient *_client;

    void handleGoaClient(GoaClient *client);

    EnvelopeGoaClient(decltype(_onCreate) cb) {
        this->_onCreate = cb;
    }
};