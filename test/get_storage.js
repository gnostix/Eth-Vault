const Web3 = require("web3");
require('dotenv').config()

// var web3 = new Web3("wss://rinkeby.infura.io/ws/v3/" + process.env.INFURA_API_KEY); // use a websocket connection
// let web3 = new Web3(new Web3.providers.WebsocketProvider('ws://localhost:7545'))
var provider = 'http://localhost:7545';
var web3Provider = new Web3.providers.HttpProvider(provider);
var web3 = new Web3(web3Provider);

var contractAddress = "0x5D5f3F22985077AB8d4A7d1A4F70008b50bD8b76"; // 
getStorageValues();


async function getStorageValues() {

    for (index = 0; index < 3; index++) {
        console.log(`[${index}]` +
            await web3.eth.getStorageAt(contractAddress, index))
    }


    newKey = web3.utils.soliditySha3(20, 1); // Use soliditySha3 instead of SHA3 because they are different / key . index
    // newKey = web3.utils.sha3(key + index, { "encoding": "hex" })
    web3.eth.getStorageAt(contractAddress, newKey).then(function (res) {
        console.log(web3.utils.hexToNumber(res));
        //        console.log(parseInt(res, 16));
    });

    // In order to read a mapping, you need the index and the key of the element from balances mapping
    index = '0000000000000000000000000000000000000000000000000000000000000002'
    key = '0000000000000000000000008398e9293ADc013389EFbcA82f52289c271Beb09'
    const balanceSlot1 = web3.utils.soliditySha3({ t: 'bytes', v: key + index });
    web3.eth.getStorageAt(contractAddress, balanceSlot1).then(function (res) {
        console.log(web3.utils.hexToNumberString(res));
        console.log(web3.utils.fromWei(res, "ether"))
    });

    // In order to read a mapping, you need the index and the key of the element from lockTime mapping
    index = '0000000000000000000000000000000000000000000000000000000000000003'
    key = '0000000000000000000000008398e9293ADc013389EFbcA82f52289c271Beb09'
    const balanceSlot = web3.utils.soliditySha3({ t: 'bytes', v: key + index });
    web3.eth.getStorageAt(contractAddress, balanceSlot).then(function (res) {
        console.log(web3.utils.hexToNumberString(res));
    });

}