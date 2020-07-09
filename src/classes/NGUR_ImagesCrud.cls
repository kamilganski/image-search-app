global class NGUR_ImagesCrud {

    public List<NGUR_ImagesWrapper> fetchImagesFromApi() {
        HttpResponse responseFromImagesApi = new Http().send(NGUR_ImagesCrud_Helper.buildRequest());

        return NGUR_ImagesWrapper.parse(responseFromImagesApi.getBody());
    }

    public List<NGUR_Image__c> getAllImagesFromApi() {
        List<NGUR_Image__c> imagesToAdd = new List<NGUR_Image__c>();
        List<NGUR_ImagesWrapper> imagesFromApi = fetchImagesFromApi();

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

    public void insertImagesToDatabase(List<NGUR_Image__c> imagesToAdd) {
        try {
            insert imagesToAdd;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }
}