// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

import ballerina/http;

# API for managing lecturer information within a faculty.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(string serviceUrl, ConnectionConfig config =  {}) returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Retrieve a list of all lecturers within the faculty
    #
    # + return - A list of lecturers 
    resource isolated function get lecturers() returns Lecturer[]|error {
        string resourcePath = string `/lecturers`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a new lecturer
    #
    # + return - Lecturer added successfully 
    resource isolated function post lecturers(Lecturer payload) returns http:Response|error {
        string resourcePath = string `/lecturers`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Retrieve the details of a specific lecturer by their staff number
    #
    # + staffNumber - Unique staff number of the lecturer
    # + return - Details of the lecturer 
    resource isolated function get lecturers/[string staffNumber]() returns Lecturer|error {
        string resourcePath = string `/lecturers/${getEncodedUri(staffNumber)}`;
        Lecturer response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing lecturer's information
    #
    # + staffNumber - Unique staff number of the lecturer
    # + return - Lecturer updated successfully 
    resource isolated function put lecturers/[string staffNumber](Lecturer payload) returns http:Response|error {
        string resourcePath = string `/lecturers/${getEncodedUri(staffNumber)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a lecturer's record by their staff number
    #
    # + staffNumber - Unique staff number of the lecturer
    # + return - Lecturer deleted successfully 
    resource isolated function delete lecturers/[string staffNumber]() returns http:Response|error {
        string resourcePath = string `/lecturers/${getEncodedUri(staffNumber)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Retrieve all the lecturers that teach a certain course
    #
    # + courseName - Name of the course
    # + return - A list of lecturers teaching the course 
    resource isolated function get lecturers/course/[string courseName]() returns Lecturer[]|error {
        string resourcePath = string `/lecturers/course/${getEncodedUri(courseName)}`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Retrieve all the lecturers that sit in the same office
    #
    # + officeNumber - Office number
    # + return - A list of lecturers in the same office 
    resource isolated function get lecturers/office/[string officeNumber]() returns Lecturer[]|error {
        string resourcePath = string `/lecturers/office/${getEncodedUri(officeNumber)}`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
}
