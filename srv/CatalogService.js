const cds = require('@sap/cds');
const { response } = require('express');
module.exports = (srv) => {
    
    srv.on('boost',async (req) =>{
        // Start a DB Transaction
    try {
        const { POs } = srv.entities;
        const ID = req.params[0];
        const tx = cds.tx(req);
        //CDS Query Lang
        await tx.update(POs).set({
            GROSS_AMOUNT: { '+=' : 20000}
        }).where(ID);
    } catch (error) {
        return req.error(500, 'Failed to update GROSS_AMOUNT.');
    }
    });

    srv.on('getOrderStatus', async(req, response) =>{
        return { "OVERALL_STATUS" : "N",}
    });

    srv.on('getLargestOrder', async(req) => {
        const { POs } = srv.entities;
        const tx = cds.tx(req);
        const recordData = tx.read(POs).orderBy({
            GROSS_AMOUNT: 'desc'
        }).limit(1);
        return recordData;
    });

    const {EmployeeSet} = srv.entities;
    srv.before(['CREATE', 'UPDATE'], EmployeeSet, (req)=>{
        if (parseFloat(req.data.salaryAmount) >= 99999999) {
            console.log("Salary Amount: ", req.data.salaryAmount);
            req.error(500, "Salary Cannot Be More than 99999999");
        }
    });

    
};

// OLD Style of Coding
// module.exports = cds.service.impl(async function(){    
//     // this.on('boost',async(req)=>{
//     //     return{
//     //         "NODE_KEY": "Dummy"
//     //     };
//     // });
//     this.on('getOrderStatus', async(req, response) => {
//         return {
//             "OVERALL_STATUS" : "N"
//         }
//     });
// });