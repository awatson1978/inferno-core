module ONCProgram
  class BulkDataAuthorization < Inferno::TestGroup
    title 'Bulk Data Authorization'
    description <<~DESCRIPTION
      Bulk Data servers are required to authorize clients using the
      [Backend Service Authorization](http://hl7.org/fhir/uv/bulkdata/STU1/authorization/)
      specification as defined in the [FHIR Bulk Data Authorization Guide](http://hl7.org/fhir/uv/bulkdata/STU1/).

      In this set of tests, Inferno serves as a Bulk Data client that attempts to authorize
      to the Bulk Data authorization server.  It also performs a number of negative tests
      to validate that the authorization service does not improperly authorize invalid
      requests.

      This test returns an access token.
    DESCRIPTION

    id :bulk_data_authorization

    input :bulk_client_id, :bulk_jwks_url_auth, :bulk_encryption_method, :bulk_token_endpoint, :bulk_scope
    output :bulk_access_token

    test do
      title 'Authorization service token endpoint secured by transport layer security'
      description <<~DESCRIPTION
        [§170.315(g)(10) Test Procedure](https://www.healthit.gov/test-method/standardized-api-patient-and-population-services) requires that
        all exchanges described herein between a client and a server SHALL be secured using Transport Layer Security (TLS) Protocol Version 1.2 (RFC5246).
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/export/index.html#security-considerations'

      run {}
    end

    test do
      title 'Authorization request fails when client supplies invalid content_type'
      description <<~DESCRIPTION
        The client requests a new access token via HTTP POST to the FHIR authorization server’s token endpoint URL, using content-type application/x-www-form-urlencoded
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/authorization/index.html#protocol-details'

      run {}
    end

    test do
      title 'Authorization request fails when client supplies invalid scope'
      description <<~DESCRIPTION
        The Backend Service Authorization specification defines the required fields for the
        authorization request, made via HTTP POST to authorization token endpoint.  This
        request includes the `scope` parameter, where the value must be a system scope.
        System scopes have the format `system/(:resourceType|*).(read|write|*).

        The OAuth 2.0 Authorization Framework describes the proper response for an
        invalid request in the client credentials grant flow:

        ```
        If the request failed client authentication or is invalid, the authorization server returns an
        error response as described in [Section 5.2](https://tools.ietf.org/html/rfc6749#section-5.2).
        ```
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/authorization/index.html#scopes'

      run {}
    end

    test do
      title 'Authorization request fails when client supplies invalid grant_type'
      description <<~DESCRIPTION
        The Backend Service Authorization specification defines the required fields for the
        authorization request, made via HTTP POST to authorization token endpoint.
        This includes the `grant_type` parameter, where the value must be `client_credentials`.

        The OAuth 2.0 Authorization Framework describes the proper response for an
        invalid request in the client credentials grant flow:

        ```
        If the request failed client authentication or is invalid, the authorization server returns an
        error response as described in [Section 5.2](https://tools.ietf.org/html/rfc6749#section-5.2).
        ```
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/authorization/index.html#protocol-details'

      run {}
    end

    test do
      title 'Authorization request fails when supplied invalid client_assertion_type'
      description <<~DESCRIPTION
        The Backend Service Authorization specification defines the required fields for the
        authorization request, made via HTTP POST to authorization token endpoint.
        This includes the `client_assertion_type` parameter, where the value must be `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`.

        The OAuth 2.0 Authorization Framework describes the proper response for an
        invalid request in the client credentials grant flow:

        ```
        If the request failed client authentication or is invalid, the authorization server returns an
        error response as described in [Section 5.2](https://tools.ietf.org/html/rfc6749#section-5.2).
        ```
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/authorization/index.html#protocol-details'

      run {}
    end

    test do
      title 'Authorization request fails when client supplies invalid JWT token'
      description <<~DESCRIPTION
        The Backend Service Authorization specification defines the required fields for the
        authorization request, made via HTTP POST to authorization token endpoint.
        This includes the `client_assertion` parameter, where the value must be
        a valid JWT. The JWT SHALL include the following claims, and SHALL be signed with the client’s private key.

        | JWT Claim | Required? | Description |
        | --- | --- | --- |
        | iss | required | Issuer of the JWT -- the client's client_id, as determined during registration with the FHIR authorization server (note that this is the same as the value for the sub claim) |
        | sub | required | The service's client_id, as determined during registration with the FHIR authorization server (note that this is the same as the value for the iss claim) |
        | aud | required | The FHIR authorization server's "token URL" (the same URL to which this authentication JWT will be posted) |
        | exp | required | Expiration time integer for this authentication JWT, expressed in seconds since the "Epoch" (1970-01-01T00:00:00Z UTC). This time SHALL be no more than five minutes in the future. |
        | jti | required | A nonce string value that uniquely identifies this authentication JWT. |

        The OAuth 2.0 Authorization Framework describes the proper response for an
        invalid request in the client credentials grant flow:

        ```
        If the request failed client authentication or is invalid, the authorization server returns an
        error response as described in [Section 5.2](https://tools.ietf.org/html/rfc6749#section-5.2).
        ```
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/authorization/index.html#protocol-details'

      run {}
    end

    test do
      title 'Authorization request succeeds when supplied correct information'
      description <<~DESCRIPTION
        If the access token request is valid and authorized, the authorization server SHALL issue an access token in response.
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/authorization/index.html#issuing-access-tokens'

      run {}
    end

    test do
      title 'Authorization request response body contains required information encoded in JSON'
      description <<~DESCRIPTION
        The access token response SHALL be a JSON object with the following properties:

        | Token Property | Required? | Description |
        | --- | --- | --- |
        | access_token | required | The access token issued by the authorization server. |
        | token_type | required | Fixed value: bearer. |
        | expires_in | required | The lifetime in seconds of the access token. The recommended value is 300, for a five-minute token lifetime. |
        | scope | required | Scope of access authorized. Note that this can be different from the scopes requested by the app. |
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/authorization/index.html#issuing-access-tokens'

      run {}
    end
  end
end
