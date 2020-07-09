({
    onInit: function (component, event, helper) {
        helper.doInit(component, event);
    },

    onSearchImages: function (component, event, helper) {
        helper.searchImages(component, event);
    },

    onSearchClear: function (component, event, helper) {
        component.set("v.title", "");
        component.set("v.searchedImages", "");
    },

    onSendEmail: function (component, event, helper) {
        helper.sendEmail(component, event);
    },

    showEmailModal: function (component, event, helper) {
        component.set("v.showEmailModal", true);
    },

    hideEmailModal: function (component, event, helper) {
        component.set("v.emailAddress", "");
        component.set("v.showEmailModal", false);
    },
});