global class NGUR_ImagesIntegration implements Schedulable {

    global void execute(SchedulableContext schedulableContext) {
        NGUR_ImagesCrud.integrateImages();
    }
}