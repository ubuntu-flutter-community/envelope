#include "envelope_goa_client.hh"

using namespace std;

void EnvelopeGoaClient::handleGoaClient(GoaClient *client) {
    this->_client = client;
    this->_onCreate(*this);
}