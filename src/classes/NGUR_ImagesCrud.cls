public with sharing class NGUR_ImagesCrud {

    public void integrateImages() {
        List<NGUR_ImagesWrapper> imagesFromApi = NGUR_ImagesCrud_Helper.fetchImagesFromApi();
        insertNewImagesFromApi(imagesFromApi);
        updateImagesFromApi(imagesFromApi);
        deleteDeletedImagesFromApi(imagesFromApi);
    }

    public void insertNewImagesFromApi(List<NGUR_ImagesWrapper> imagesFromApi) {
        Set<String> imagesFromApiIds = new Set<String>();

        for (NGUR_ImagesWrapper imageFromApi : imagesFromApi) {
            if (String.isNotBlank(imageFromApi.id)) {
                imagesFromApiIds.add(imageFromApi.id);
            }
        }

        List<NGUR_Image__c> images = [SELECT NGUR_Id__c FROM NGUR_Image__c WHERE NGUR_Id__c IN :imagesFromApiIds];
        Set<String> imagesFromSfIds = new Set<String>();

        for (NGUR_Image__c image : images) {
            imagesFromSfIds.add(image.NGUR_Id__c);
        }

        List<NGUR_ImagesWrapper> imagesToAdd = new List<NGUR_ImagesWrapper>();

        for (NGUR_ImagesWrapper imageFromApi : imagesFromApi) {
            if (imagesFromSfIds.contains(imageFromApi.id)) {
                imagesToAdd.add(imageFromApi);
            }
        }

        try {
            insert NGUR_ImagesCrud_Helper.buildImagesFromApiData(imagesToAdd);
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }

    public void updateImagesFromApi(List<NGUR_ImagesWrapper> imagesFromApi) {
        Set<String> imagesFromApiIds = new Set<String>();

        for (NGUR_ImagesWrapper imageFromApi : imagesFromApi) {
            if (String.isNotBlank(imageFromApi.id)) {
                imagesFromApiIds.add(imageFromApi.id);
            }
        }

        List<NGUR_Image__c> imagesToUpdate = [
                SELECT Id, NGUR_Id__c, NGUR_Album_Id__c, NGUR_Title__c, NGUR_Image_Url__c, NGUR_Thumbnail_Url__c
                FROM NGUR_Image__c WHERE NGUR_Id__c IN :imagesFromApiIds
        ];

        for (NGUR_ImagesWrapper imageFromApi : imagesFromApi) {
            for (NGUR_Image__c image : imagesToUpdate) {
                if (imageFromApi.id.equalsIgnoreCase(image.NGUR_Id__c)) {
                    image.NGUR_Id__c = imageFromApi.id;
                    image.NGUR_Album_Id__c = imageFromApi.albumId;
                    image.NGUR_Title__c = imageFromApi.title;
                    image.NGUR_Image_Url__c = imageFromApi.url;
                    image.NGUR_Thumbnail_Url__c = imageFromApi.thumbnailUrl;
                }
            }
        }

        try {
            update imagesToUpdate;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }

    public void deleteDeletedImagesFromApi(List<NGUR_ImagesWrapper> imagesFromApi) {
        Set<String> imagesFromApiIds = new Set<String>();

        for (NGUR_ImagesWrapper imageFromApi : imagesFromApi) {
            if (String.isNotBlank(imageFromApi.id)) {
                imagesFromApiIds.add(imageFromApi.id);
            }
        }

        List<NGUR_Image__c> imagesToDelete = [SELECT Id, NGUR_Id__c FROM NGUR_Image__c WHERE NGUR_Id__c NOT IN :imagesFromApiIds];

        try {
            delete imagesToDelete;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }
}