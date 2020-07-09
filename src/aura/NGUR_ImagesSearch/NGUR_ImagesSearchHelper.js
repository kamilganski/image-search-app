({
    doInit: function (component, event) {
        component.set("v.columns", [
            {label: "Title", fieldName: "NGUR_Title__c", type: "text"},
            {label: "Image URL", fieldName: "NGUR_Image_Url__c", type: "url"},
            {label: "Thumbnail URL", fieldName: "NGUR_Thumbnail_Url__c", type: "url"}
        ]);
    },

    searchImages: function (component, event) {
        let helpSelf = this;
        let title = component.get("v.title");
        let action = component.get("c.searchImagesByTitle");

        action.setParams({
            title: title
        });
        action.setCallback(this, function (response) {
            let state = response.getState();

            if (state === "SUCCESS") {
                let data = response.getReturnValue();

                if ($A.util.isEmpty(data)) {
                    helpSelf.showToast("info", "Info","No images found");
                } else {
                    component.set("v.searchedImages", data);
                }
            } else if (state === "ERROR") {
                let errors = response.getError();
                helpSelf.showToast("error", "Error", errors[0].message);
            } else {
                helpSelf.showToast("error", "Error","Unknown error");
            }
        });
        $A.enqueueAction(action);
    },

    sendEmail: function (component, event) {
        let helpSelf = this;
        let emailAddress = component.get("v.emailAddress");
        let foundImages = component.get("v.searchedImages");
        let action = component.get("c.sendEmailToSpecificEmailAddress");

        action.setParams({
            emailAddress: emailAddress,
            foundImages: foundImages
        });
        action.setCallback(this, function (response) {
            let state = response.getState();

            if (state === "SUCCESS") {
                let result = response.getReturnValue();

                if (result) {
                    helpSelf.showToast("success", "Success","Email send");
                    component.set("v.emailAddress", "");
                    component.set("v.showEmailModal", false);
                } else {
                    helpSelf.showToast("error", "Error","Email not send");
                }
            } else if (state === "ERROR") {
                let errors = response.getError();
                helpSelf.showToast("error", "Error", errors[0].message);
            } else {
                helpSelf.showToast("error", "Error","Unknown error");
            }
        });
        $A.enqueueAction(action);
    },

    showToast : function(type, title, message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": type,
            "title": title,
            "message": message
        });
        toastEvent.fire();
    }
});