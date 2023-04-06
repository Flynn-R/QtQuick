function createTable(tx, index) {
    var tableName = (index == 0 ? 'Solar_System' : (index == 1 ? 'Milky_Way' : 'Local_Group'))

    const sqlQuery = 'CREATE TABLE IF NOT EXISTS ' + tableName + ' (' +
                   'ID INTEGER PRIMARY KEY, ' +
                   'Name TEXT NOT NULL, ' +
                   'Mass TEXT NOT NULL);'
    tx.executeSql(sqlQuery)
}

function addRecord(tx, index, name, mass) {
    var tableName = (index == 0 ? 'Solar_System' : (index == 1 ? 'Milky_Way' : 'Local_Group'))

    const sqlQuery = 'INSERT INTO ' + tableName + ' (Name, Mass) ' +
                   'VALUES (\'%1\', \'%2\');'.arg(name).arg(mass)

    return tx.executeSql(sqlQuery)
}

function readTable(tx, index, model) {
    model.clear()
    var tableName = (index == 0 ? 'Solar_System' : (index == 1 ? 'Milky_Way' : 'Local_Group'))

    const sqlQuery = 'SELECT * FROM ' + tableName + ';'
    var res = tx.executeSql(sqlQuery)

    for (var i = 0; i < res.rows.length; ++i)
        model.appendRow({ID: res.rows.item(i).ID, Name: res.rows.item(i).Name, Mass: res.rows.item(i).Mass})
}

function editTable(tx, index, id, name, mass) {
    var tableName = (index == 0 ? 'Solar_System' : (index == 1 ? 'Milky_Way' : 'Local_Group'))

    const sqlQuery = 'UPDATE ' + tableName + ' SET Name = \'%1\', Mass = \'%2\' WHERE ID = \'%3\';'.arg(name).arg(mass).arg(id)
    tx.executeSql(sqlQuery)
}
