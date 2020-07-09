({
    doInit: function (component, event) {
        component.set("v.columns", [
            {label: "Title", fieldName: "NGUR_Title__c", type: "text"},
            {label: "Image URL", fieldName: "NGUR_Image_Url__c", type: "url"},
            {label: "Thumbnail URL", fieldName: "NGUR_Thumbnail_Url__c", type: "url"}
        ]);
    },

    searchImages: function (component, event) {
        let title = component.get("v.title");
        let action = component.get("c.searchImagesByTitle");

        action.setParams({
            title: title
        });
        action.setCallback(this, function (response) {
            let state = response.getState();

            if (state === "SUCCESS") {
                let data = response.getReturnValue();

                component.set("v.searchedImages", data);
            } else {
                console.log('error');
            }
        });
        $A.enqueueAction(action);
    }
});