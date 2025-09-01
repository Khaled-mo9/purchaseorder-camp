const { insert } = require('@sap/cds');
const cds = require('@sap/cds');
const { purchaseorderheader, purchaseorderitems } = cds.entities("khaled.db.purchasecontext");

const puchaseSrv = function(srv) {
    // Read => purchaseorderheader
    srv.on("READ", "purchaseorderheader", async (req, res) => {
        var results = [];
        results = await cds.tx(req).run(
            SELECT.from(purchaseorderheader)
        );
        return results;
    });

    //create => purchaseorderheader
    srv.on("CREATE", "purchaseorderheader",async (req, res)=>{       
        try {
            var results = [];
            results = await cds.transaction(req)
                                .run(
                                    INSERT.into(purchaseorderheader).entries(req.data)
                                );
                                 
        } catch (error) {
            req.error(500, 'Faild to create a new data' + error.message);   
        }
    });

    // update => purchaseorderheader

    srv.on("UPDATE", "purchaseorderheader", async (req, res)=> {
        try {
            const { purchase_order_number } = req.data;

            const exsitHeader = await UPDATE('purchaseorderheader')
            .set(req.data)
            .where({ purchase_order_number });

            if (!exsitHeader) {
            return req.error(404, `Purchase order ${purchase_order_number} not found`);
            }

            const updatedPO = await SELECT.one
            .from('purchaseorderheader')
            .where({ purchase_order_number });

            return updatedPO;

        } catch (err) {
            return req.error(500, 'Internal server error while updating purchase order');
        }
    })

    //delete=> purchaseorderheader
    srv.on("DELETE", "purchaseorderheader", async (req, res)=> {
        try {
            const { purchase_order_number } = req.data;
            const deleted = await cds.transaction(req).run(
                DELETE.from(purchaseorderheader).where({purchase_order_number})
            )

            if (deleted === 1) {
                return req.error(204, `Purchase order ${purchase_order_number} deleted successfully` );
            } else {
                return req.error(404, `Purchase order ${purchase_order_number} not found`);
            }
        } catch (error) {
            return req.error(500, `Error deleting purchase order: ${err.message}`);
        }
    })
}


module.exports = puchaseSrv;