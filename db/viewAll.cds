namespace khaled.db;

using { khaled.db.materialcontext as mc, khaled.db.purchasecontext as pc  } from './purchaseModel';


entity viewAll as select from 
            pc.purchaseorderheader as a inner join pc.purchaseorderitems as b
            on a.purchase_order_number = b.purchase_order_number
            inner join mc.materialmaster as c 
            on b.material_number = c.material_number
            inner join mc.materialdescription as d
            on c.material_number = d.material_number
{
    key a.purchase_order_number,
    b.po_item,
    b.delivery_date,
    c.material_number,
    c.material_group,
    d.language,
    d.material_description
}