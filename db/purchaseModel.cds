namespace khaled.db;

using { khaled.customAspect as aspect } from './customAspect';
using { managed } from '@sap/cds/common';

context purchasecontext {
    entity purchaseorderheader {
        key purchase_order_number : Integer64;
        company_code              : String(4);
        po_type                   : String(4);
        vendor                    : String(10);
        document_date             : Date;
        purchasing_org            : String(4);
        purchasing_group          : String(3);
        currency                  : String(3);
        items : Association to many purchaseorderitems 
            on items.purchase_order_number = purchase_order_number;
    }

    annotate purchaseorderheader with {
        purchase_order_number @title : '{i18n>bp_poNum}';
        company_code          @title : '{i18n>bp_cCode}';
        po_type               @title : '{i18n>bp_poType}';
        vendor                @title : '{i18n>bp_vendor}';
        document_date         @title : '{i18n>bp_docDate}';
        purchasing_org        @title : '{i18n>bp_purchOrg}';
        purchasing_group      @title : '{i18n>bp_purchGroup}';
        currency              @title : '{i18n>bp_currency}';
        items                 @title : '{i18n>bp_items}';
    }

    entity purchaseorderitems : managed {
        key purchase_order_number : Integer64;
        key po_item               : Integer;
        material_number           : String(18);
        quantity                  : Decimal(13,3);
        uom                       : String(3);
        net_price                 : Decimal(11,2);
        price_unit                : Integer;
        delivery_completed        : Boolean;
        delivery_date             : Date;
        materials: Association to one materialcontext.materialmaster 
            on materials.material_number = material_number;
    }

    annotate purchaseorderitems with {
        purchase_order_number @title : '{i18n>bp_poNum}';
        po_item               @title : '{i18n>bp_poItem}';
        material_number       @title : '{i18n>bp_materialNum}';
        quantity              @title : '{i18n>bp_quantity}';
        uom                   @title : '{i18n>bp_uom}';
        net_price             @title : '{i18n>bp_netPrice}';
        price_unit            @title : '{i18n>bp_priceUnit}';
        delivery_completed    @title : '{i18n>bp_deliveryCompleted}';
        delivery_date         @title : '{i18n>bp_deliveryDate}';
        materials             @title : '{i18n>bp_material}';
    }
}

context materialcontext {
    entity materialmaster {
        key material_number       : String(18);
        material_type             : String(4);
        industry_sector           : String(1);
        material_group            : String(9);
        base_uom                  : String(3);
        texts : Association to many materialdescription 
            on texts.material_number = material_number 
            and texts.language = $user.locale;
    }

    annotate materialmaster with {
        material_number  @title : '{i18n>bp_materialNum}';
        material_type    @title : '{i18n>bp_materialType}';
        industry_sector  @title : '{i18n>bp_industrySector}';
        material_group   @title : '{i18n>bp_materialGroup}';
        base_uom         @title : '{i18n>bp_baseUom}';
        texts            @title : '{i18n>bp_texts}';
    }

    entity materialdescription : managed {
        key material_number       : String(18);
        key language              : aspect.Lang;
        material_description      : localized String(400);
    }

    annotate materialdescription with {
        material_number      @title : '{i18n>bp_materialNum}';
        language             @title : '{i18n>bp_language}';
        material_description @title : '{i18n>bp_materialDesc}';
    }
}
