const cds = require('@sap/cds');
const { employees } = cds.entities("anubhav.db.master");

module.exports = (srv) => {
    srv.on("READ",'ReadEmployeeSrv', async(req)=>{
        const tx = await cds.tx(req);
        var results = await tx.run(SELECT.from(employees).limit(5));
        for (let i = 0; i < results.length; i++) {
            const element = results[i];
            element.nameMiddle = 'Kumar';        
        }
        return results;
    })
}