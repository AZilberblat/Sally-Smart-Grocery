import * as functions from 'firebase-functions'
import SquareConnect = require('square-connect');

const defaultClient = SquareConnect.ApiClient.instance;
// Configure OAuth2 access token for authorization: oauth2
const oauth2 = defaultClient.authentications['oauth2'];
defaultClient.basePath = 'https://connect.squareupsandbox.com';

oauth2.accessToken = "EAAAEElbAXdjTXlcinOIYTRvbMOPg-H2qC0rrZsuNG0EB0_lBWL5PoIkRMutOLti";   
const squareSandboxPaymentsApiEndpoint = 'https://connect.squareupsandbox.com/v2/payments';
// Pass client to API
const api = new SquareConnect.LocationsApi();
const paymentsApi = new SquareConnect.PaymentsApi();

export const clearCartOnNewOrder = functions.firestore
  .document('users/{user}/orders/{order}')
  .onCreate(async (snap, context) => {
    const params = context.params
    const documents = await snap.ref.parent.parent
      ?.collection('cart')
      .listDocuments()
    documents!.forEach(async document => {
      await document.delete()
    })
    console.log(`New order placed: ${params.order}. Cart cleared.`)
  })

export const placeSquareOrder = functions.https.onCall(async (data, context) => {
  const paymentResult: SquareConnect.CreatePaymentResponse = await paymentsApi.createPayment(data);
  console.log(paymentResult); 
})
