namespace  khaled.db;
using { cuid } from '@sap/cds/common';


entity Posts : cuid {
    userId : Integer;
    title : String;
    body   : String;
}