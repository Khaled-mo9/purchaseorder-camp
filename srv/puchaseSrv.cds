using { khaled.db.purchasecontext, khaled.db.materialcontext  } from '../db/purchaseModel';



service purchaseServ @(path: 'purchaseService') {
    entity purchaseorderheader as projection on purchasecontext.purchaseorderheader;
    entity purchaseorderitems as projection on purchasecontext.purchaseorderitems;
    entity materialmaster as projection on materialcontext.materialmaster;
    entity materialdescription as projection on materialcontext.materialdescription;
    
}

@impl : './helper.js'
service helperSrv @(path: 'helperService'){
    entity purchaseorderitems as projection on purchasecontext.purchaseorderitems;
        action increment(purchase_order_number: Integer) returns {
                message: String;
                updatedQuantity: Decimal(13, 3);
            };
        function totals(purchase_order_number: Integer) returns {
            message: String;
            items : String;
        }
}

