// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require_tree .
//= require bootstrap-datepicker


$(document).ready(function(e){
    $('.date-picker').datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true,startDate: "dateToday", setDate: new Date()});


    regex_emails = [];

    regex_emails_set = {};


    function initializeAutoComplete(){
        $( "#tags" ).autocomplete({
            source: regex_emails,
            select: function (event, ui) {
                $("#tags_code").val(ui.item.value);
            }
        });
    }

    function SubstringPresentInArray(array, subString){
        var indexValue = -1;
        $.each(array, function( index, value ) {
            if (subString.indexOf(value) >= 0){
                indexValue = index;

            }
        });
        return indexValue;

    }

    $("#tags").on("change paste keyup", function() {

        var searchValue = $(this).val();
        if (searchValue.length <= 2){
            regex_emails = [];
            initializeAutoComplete();
            return
        }
        var keys = Object.keys(regex_emails_set);
        var index = SubstringPresentInArray(keys, searchValue);
        if (index >= 0){
            var key = keys[index];
            regex_emails = regex_emails_set[key];
            initializeAutoComplete();
            return
        }
        $.ajax({
            url:'/api/get-email',
            type:'POST',
            dataType:'json',
            data:{
                'regex':searchValue
            },
            success:function(data){
                regex_emails = data['emails'];
                regex_emails_set[searchValue] = regex_emails;
                initializeAutoComplete();
                console.log(data['emails']);

            },
            error:function(data){

            }
        });
    });

});