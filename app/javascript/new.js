function inputChange() {

  const postForm = document.getElementById("item_form")
  if (!postForm) return;  // 要素が存在しない場合は処理を終了


  const itemPrice = document.getElementById("item-price")

  itemPrice.addEventListener('input', function(){ 

  const addTaxPrice = document.getElementById("add-tax-price")
  const salesProfit = document.getElementById("profit")
    const value = itemPrice.value
    addTaxPrice.innerHTML = Math.floor(value * 0.1)
    salesProfit.innerHTML = Math.floor(value * 0.9)

  })

}

window.addEventListener('turbo:load', inputChange)
