# Solidity_Smart_Contract_Campaign

 Üreticinin finansman bulmasını ve finansmanın üreticiye güvenmesini sağlayan bir akıllı sözleşme.
 
 A smart contract where you can safely collect financing from both the financing and producer perspective.

![CampaignFactory](https://user-images.githubusercontent.com/76453513/196037289-b66b41b3-3bf8-45f4-af20-38c52918cc00.png)

Tablo1. Table1.

 Tablo1, sözleşmemizi dağıtırken birden fazla şekilde dağıtılmasını sağlamak amacıyla yazılmış bir tablodur. Bu tablonun kodunu daha farklı şekillerde yazabilirdi, ancak hem güvenlik hemde gas ücreti açısından fayda sağladığı için bu şekilde yazılması tercih adildi. createCampaign fonksiyonu çağırıldığı zaman alınan uint _mini değişkeni ile yatırımcı olabilmek için minimum gerekli olan para değeri alınmış oluyor. Aynı fonksiyon içerisinde fonksiyonu çağıran kişinin adresi alınarak kampanyanın yöneticiliği ona veriliyor. Bu kampanyalar listelenmek için gas ücreti gerektirmeyen getPublishedCampaign fonksiyonunda tutuluyor.
 
 Table1 is a table written to ensure that our contract is distributed in more than one way while distributing it. We could have written the code for this table in different ways, but it was fair to write it this way as it provides benefits both in terms of security and gas cost. When the createCampaign function is called, the uint _mini variable is taken and the minimum required money value is taken to be an investor. We call the investor is subscriber. In the same function, the address of the person calling the function is taken and the management of the campaign is given to him. These campaigns are kept in the getPublishedCampaign function, this function does not spend gas fee.



![ContractCampaignVariables](https://user-images.githubusercontent.com/76453513/196037312-2cdb8f26-9dd2-4a0d-ad3e-4aeec40d750b.png)

Tablo2. Table2.



![RequestStruct](https://user-images.githubusercontent.com/76453513/196037320-5a55f93e-934f-4816-a3c8-c8a7aa56de24.png)

Tablo3. Table3.



![ContractCampaignFunctions](https://user-images.githubusercontent.com/76453513/196037327-1871d89f-8012-4c96-8776-26ceef612ccd.png)

Tablo4. Table4.


