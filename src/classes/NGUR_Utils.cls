public with sharing class NGUR_Utils {

    public static String getCustomSettingValue(String customSettingName) {
        NGUR_Settings__c customSettingItem = NGUR_Settings__c.getInstance(customSettingName);
        if (customSettingItem == null) {
            return '';
        }
        return customSettingItem.Value__c;
    }
}