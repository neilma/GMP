$(document).ready(function() {
    $("body").on("click", "#export_link", function(){
        $(".cgu-policy-search-result table:visible").table2excel({
            //exclude: ".excludeThisClass",
            name: "Policy Data",
            filename: "GMP_data" //do not include extension
        });
    });
});