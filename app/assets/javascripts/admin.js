//= require jquery
//= require jquery_ujs
//= require jquery.datepair
//= require bootstrap
//= require fastclick
//= require admin/custom.js
//= require jquery.timepicker
//= require moment
//= require daterangepicker
//= require jquery.tagsinput
//= require jquery.datepair
//= require dataTables/jquery.dataTables
//= require jquery.dataTables.yadcf

function HTMLDecode(s){
    return jQuery('<div></div>').html(s).text();
}

if($('#users-table').length > 0) {
    $('#users-table').dataTable({
        "processing": true,
        "serverSide": true,
        "ajax": $('#users-table').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            { "data": "id" },
            { "data": "email" },
            { "data": "boost" },
            { "data": "active" },
            { "data": "work" },
            { "data": "chain_count" },
            { "data": "earning" },
            { "data": "sponsor_id" },
            { "data": "name" },
            { "data": "refer_id" },
            { "data": "mobile_number" },
            { "data": function(row) {
                return "<a class='btn btn-block btn-info' href='/admin/users/" + row.id + "'>Show</a>";
            }},
            { "data": function(row) {
                return "<a class='btn btn-block btn-info' href='/admin/users/" + row.id + "/edit'>Edit</a>";
            }},
            { "data": function(row) {
                return "<a id='button2_" + row.id + "' class='btn btn-block btn-warning' href='/admin/users/" + row.id + ".js' data-remote='true' data-method='patch'>" + (row.active == 'true' ? 'Block' : 'Activate') + "</a>";
            }},
            { "data": function(row){
                return "<a id='button3_" + row.id + "' class='btn btn-block btn-primary' href='/admin/user-tree/" + row.id + "'>Tree</a>";
            }},
            { "data": function(row){
                if(row.boost === "true") {
                    return "<a id='button4_" + row.id + "' class='btn btn-block btn-primary' href='#!'>Boost Activated</a>";
                } else {
                    return "<a id='button4_" + row.id + "' class='btn btn-block btn-primary' href='/admin/users/" + row.id + "/activate-boost' data-remote='true' data-method='post'>Activate Boost</a>";
                }
            }},
            { "data": function(row){
                return "<a id='button5_" + row.id + "' class='btn btn-block btn-primary' href='/admin/change/password/" + row.id + "'>Change Password</a>";
            }}
        ]

    }).yadcf([
        { column_number: 0, filter_type: 'text' },
        { column_number: 1, filter_type: 'text', "filter_delay": 1000 },
        { column_number: 2, data: [{ value: 1, label: 'Yes' }, { value: 0, label: 'No' }] },
        { column_number: 3, data: [{ value: 1, label: 'Yes' }, { value: 0, label: 'No' }] },
        { column_number: 4, filter_type: '' },
        { column_number: 5, filter_type: '' },
        { column_number: 6, filter_type: '' },
        { column_number: 7, filter_type: 'text' },
        { column_number: 8, filter_type: 'text', "filter_delay": 1000 },
        { column_number: 9, filter_type: 'text' },
        { column_number: 10, filter_type: 'text' }
    ]);
}

if($('#payment-transactions-table').length > 0) {
    $('#payment-transactions-table').dataTable({
        "processing": true,
        "serverSide": true,
        "ajax": $('#payment-transactions-table').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            { "data": "id" },
            { "data": "amount" },
            { "data": "status" },
            { "data": "mobile_number" },
            { "data": "payment_type" },
            { "data": "created_at" }
        ]

    }).yadcf([
        { column_number: 0, filter_type: 'text' },
        { column_number: 1, filter_type: 'text' },
        { column_number: 2, filter_type: 'text' },
        { column_number: 3, filter_type: 'text' },
        { column_number: 4, data: [{ value: 0, label: 'PayTM' }, { value: 1, label: 'Bank' }, { value: 2, label: 'Recharge' }] },
        { column_number: 5, filter_type: '' }
    ]);
}

if($('#enquiries-table').length > 0) {
    $('#enquiries-table').dataTable({
        "processing": true,
        "serverSide": true,
        "ajax": $('#enquiries-table').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            { "data": "id" },
            { "data": "subject" },
            { "data": "enquiry" },
            { "data": "mobile_number" },
            { "data": "status" },
            { "data": "date" },
            { "data": function(row) {
                if(row.status === 'Unresolved') {
                    return "<a rel='nofollow' data-method='patch' class='btn btn-block btn-warning'  href='/admin/enquiries/" + row.id + "'>Mark Resolved</a>"
                } else {
                    return "";
                }
            }}
        ]
    }).yadcf([
        { column_number: 0, filter_type: 'text' },
        { column_number: 1, filter_type: '' },
        { column_number: 2, filter_type: '' },
        { column_number: 3, filter_type: '' },
        { column_number: 4, filter_type: '' },
        { column_number: 5, data: [{ value: 0, label: 'Unresolved' }, { value: 1, label: 'Resolved' }] }
    ]);
}

if($('#conversions-table').length > 0) {
    $('#conversions-table').dataTable({
        "processing": true,
        "serverSide": true,
        "ajax": $('#conversions-table').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            { "data": "id" },
            { "data": "transaction_id" },
            { "data": "company" },
            { "data": "offer" },
            { "data": "deal" },
            { "data": "status" },
            { "data": "user" },
            { "data": function(row) {
                if(row.status === 'Unresolved') {
                    return "<a rel='nofollow' data-method='patch' class='btn btn-block btn-warning'  href='/admin/conversions/" + row.id + "'>Mark Resolved</a>"
                } else {
                    return "";
                }
            }}
        ]
    }).yadcf([
        { column_number: 0, filter_type: 'text' },
        { column_number: 1, filter_type: '' },
        { column_number: 2, filter_type: '' },
        { column_number: 3, filter_type: '' },
        { column_number: 4, filter_type: '' },
        { column_number: 5, data: [{ value: 0, label: 'Unresolved' }, { value: 1, label: 'Resolved' }] }
    ]);
}

$(function () {
    $('[data-toggle="tooltip"]').tooltip()
});