public with sharing class NGUR_ImagesCrud_Helper {

    public static HttpRequest buildRequest() {
        HttpRequest requestToImagesApi = new HttpRequest();

        requestToImagesApi.setHeader('Accept', 'application/json');
        requestToImagesApi.setHeader('Content-Type', 'application/json');
        requestToImagesApi.setMethod('GET');
        requestToImagesApi.setEndpoint(NGUR_Utils.getCustomSettingValue('NGUR_ImagesApiUrl'));

        return requestToImagesApi;
    }
}