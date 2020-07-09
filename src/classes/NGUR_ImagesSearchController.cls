public with sharing class NGUR_ImagesSearchController {

    @AuraEnabled
    public static List<NGUR_Image__c> searchImagesByTitle(String title) {
        try {
            String titleLikeQuery = '%' + title + '%';

            return [SELECT NGUR_Title__c, NGUR_Image_Url__c, NGUR_Thumbnail_Url__c FROM NGUR_Image__c WHERE NGUR_Title__c LIKE :titleLikeQuery];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}