public with sharing class NGUR_ImagesWrapper {

    public String id;
    public String albumId;
    public String title;
    public String url;
    public String thumbnailUrl;

    public static List<NGUR_ImagesWrapper> parse(String responseBody) {
        return (List<NGUR_ImagesWrapper>) JSON.deserialize(responseBody, List<NGUR_ImagesWrapper>.class);
    }
}