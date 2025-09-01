
using { khaled.db.purchasecontext } from '../db/purchaseModel';


service incrementServ {
    entity purchaseorderitems as projection on purchasecontext.purchaseorderitems;
        action increment(purchase_order_number: Integer) returns {
                message: String;
                updatedQuantity: Decimal(13, 3);
            };
}