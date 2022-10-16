# Solidity_Smart_Contract_Campaign

 Üreticinin finansman bulmasını ve finansmanın üreticiye güvenmesini sağlayan bir akıllı sözleşme.
 
 A smart contract where you can safely collect financing from both the financing and producer perspective.

![CampaignFactory](https://user-images.githubusercontent.com/76453513/196037289-b66b41b3-3bf8-45f4-af20-38c52918cc00.png)

Tablo1. Table1.

 Tablo1, sözleşmemizi dağıtırken birden fazla şekilde dağıtılmasını sağlamak amacıyla yazılmış bir tablodur. Bu tablonun kodunu daha farklı şekillerde yazabilirdi, ancak hem güvenlik hemde gas ücreti açısından fayda sağladığı için bu şekilde yazılması tercih adildi. createCampaign fonksiyonu çağırıldığı zaman alınan uint _mini değişkeni ile yatırımcı olabilmek için minimum gerekli olan para değeri alınmış oluyor. Aynı fonksiyon içerisinde fonksiyonu çağıran kişinin adresi alınarak kampanyanın yöneticiliği ona veriliyor. Bu kampanyalar listelenmek için gas ücreti gerektirmeyen getPublishedCampaign fonksiyonunda tutuluyor.
 
 Table1 is a table written to ensure that our contract is distributed in more than one way while distributing it. We could have written the code for this table in different ways, but it was fair to write it this way as it provides benefits both in terms of security and gas cost. When the createCampaign function is called, the uint _mini variable is taken and the minimum required money value is taken to be an investor. We call the investor is subscriber. In the same function, the address of the person calling the function is taken and the management of the campaign is given to him. These campaigns are kept in the getPublishedCampaign function, this function does not spend gas fee.

![ContractCampaignVariables](https://user-images.githubusercontent.com/76453513/196037312-2cdb8f26-9dd2-4a0d-ad3e-4aeec40d750b.png)

Tablo2. Table2.

 Tablo2, Bu tablo akıllı kontratımızda yer alan veri tiplerini gösteren tablodur. manager isimli veri tipi Tablo1 de bahsedilen createCampaign fonksiyonunu çağıran kişidir. subscribers bir mapping veri tipinde finansmanları tutan bir listedir ve adrese karşılık bool değeri tutar. Başlangıç değeri false'dur eğer finansman olabilecek kadar bir ödeme yaptıysanız o zaman adresinize karşılık gelen değer true olur ve gerçek bir subscriber olursunuz. Request bir struct yapısıdır. İçerisinde manager'in oluşturduğu istek hakkında bilgiler yer alır.
 
 Table2, this table is the table showing the data types included in our smart contract. The data type named manager is the person who calls the createCampaign function mentioned in Table1. subscribers is a list holding finances in a mapping data type and holds a bool value against the address. The initial value is false. If you have paid enough to be financeman then the value corresponding to your address will be true and you will be a real subscriber. Request is a struct. It contains information about the request created by the manager.

![RequestStruct](https://user-images.githubusercontent.com/76453513/196037320-5a55f93e-934f-4816-a3c8-c8a7aa56de24.png)

Tablo3. Table3.

 Tablo3, istekler hakkında bilgi içeren tablodur. recipient, finansman ve kampanya sahibi (üretici) arasındaki güven bağını arttırmayı hedefler. Üretici direk kendi hesabına parayı alamaz, para direk gitmesi istenilen tedarikçiye ulaştırılır. complete ile daha önceden onaylanan istekler için tekrardan gas ücreti harcanması önlenmiştir. acceptorsAccount ile gerekli olduğu durumlarda kimlerin bu isteği onayladığı görülmesi hedeflenmiştir.
 
 Table3 is the table containing information about the requests. recipient, aims to increase the bond of trust between the subscribers and the campaign owner (manager). The producer cannot receive the money directly for his own account, the money is sent directly to the supplier to whom it is intended. With complete, gas fees are prevented from being used again for previously approved requests. With acceptorsAccount, it is aimed to see who approved this request when necessary.

![ContractCampaignFunctions](https://user-images.githubusercontent.com/76453513/196037327-1871d89f-8012-4c96-8776-26ceef612ccd.png)

Tablo4. Table4.

 Tablo4, fonksiyonların yer aldığı tablodur. createRequest fonksiyonu ile yeni bir istek oluşturulabilir. acceptRequest ile oluşturulan bu istekler subscribers (üyeler) tarafından onaylanır veya istenmeyen, gereksiz görünen durumlarda işlem yapılmaz. finalizeRequest fonksiyonu ile istekleri onaylayanların sayısı (acceptCount) yarıyı geçer ise complete değeri true olur. Bu da value değeri kadar miktarı recipient adresine göndererek tedariği sağlamış olur.
 
 Table4 is the table containing the functions. A new request can be created with the createRequest function. These requests created with acceptRequest are approved by the subscribers or no action is taken in cases that seem undesirable and unnecessary. If the number of acceptCount of requests with the finalizeRequest function exceeds half, the value of complete will be true. This ensures the supply by sending the amount of value to the recipient address.
