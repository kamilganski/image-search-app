public with sharing class NGUR_ImagesCrud_Helper {

    public static List<NGUR_ImagesWrapper> fetchImagesFromApi() {
        HttpResponse responseFromImagesApi = new Http().send(buildRequest());

        return NGUR_ImagesWrapper.parse(responseFromImagesApi.getBody());
    }

    public static List<NGUR_Image__c> buildImagesFromApiData(List<NGUR_ImagesWrapper> imagesToBuild) {
        List<NGUR_Image__c> imagesToAdd = new List<NGUR_Image__c>();
        List<NGUR_ImagesWrapper> imagesFromApi = imagesToAdd.isEmpty() ? fetchImagesFromApi() : imagesToBuild;

        for (NGUR_ImagesWrapper imageFromApi : imagesFromApi) {
            NGUR_Image__c imageToAdd = new NGUR_Image__c();
            imageToAdd.NGUR_Id__c = imageFromApi.id;
            imageToAdd.NGUR_Album_Id__c = imageFromApi.albumId;
            imageToAdd.NGUR_Title__c = imageFromApi.title;
            imageToAdd.NGUR_Image_Url__c = imageFromApi.url;
            imageToAdd.NGUR_Thumbnail_Url__c = imageFromApi.thumbnailUrl;

            imagesToAdd.add(imageToAdd);
        }

        return imagesToAdd;
    }

    private static HttpRequest buildRequest() {
        HttpRequest requestToImagesApi = new HttpRequest();

        requestToImagesApi.setHeader('Accept', 'application/json');
        requestToImagesApi.setHeader('Content-Type', 'application/json');
        requestToImagesApi.setMethod('GET');
        requestToImagesApi.setEndpoint(NGUR_Utils.getCustomSettingValue('NGUR_ImagesApiUrl'));

        return requestToImagesApi;
    }
}