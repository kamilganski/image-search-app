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

    @AuraEnabled
    public static Boolean sendEmailToSpecificEmailAddress(String emailAddress, List<NGUR_Image__c> foundImages) {
        try {
            Boolean result = true;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setSubject('Found images');
            mail.setToAddresses(new List<String>{emailAddress});
            mail.setPlainTextBody(prepareEmailBody(foundImages));

            List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});

            for (Messaging.SendEmailResult emailResult : emailResults) {
                if (!emailResult.isSuccess()) {
                    result = false;
                    break;
                }
            }

            return result;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static String prepareEmailBody(List<NGUR_Image__c> foundImages) {
        String emailBody = '';
        Integer index = 1;

        for (NGUR_Image__c image : foundImages) {
            emailBody += index + '. Title: ' + image.NGUR_Title__c + ', Image URL: ' + image.NGUR_Image_Url__c + ', Thumbnail URL: ' + image.NGUR_Thumbnail_Url__c + '\n';
            index++;
        }

        return emailBody;
    }
}