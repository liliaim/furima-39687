const pay = () => {
    const itemId = document.getElementById('item-id').value;
    const publicKey = gon.public_key 
    const payjp = Payjp(publicKey) 
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
        payjp.createToken(numberElement).then(function (response) {
        const renderDom = document.getElementById("charge-form");
        const itemIdObj = `<input value=${itemId} name='item_id' type="hidden">`;
          if (response.error) {
        renderDom.insertAdjacentHTML("beforeend", itemIdObj);
    
      } else {
        const token = response.id;
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        renderDom.insertAdjacentHTML("beforeend", itemIdObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();

    });

    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
