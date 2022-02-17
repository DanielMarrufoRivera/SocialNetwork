//
//  LocalData.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//


/// Used to provide local data for debug purposes
struct LocalData {
    /// Use local data instead of remote server
    static let isLocal = true
    static let Personas = [
        Person(
            id: 1,
            name: "Juan Jaquez",
            profile_path:"https://conceptodefinicion.de/wp-content/uploads/2015/03/hombre.jpg"
        ),
        Person(
            id: 2,
            name: "Margarita Delgado",
            profile_path:"https://www.ashoka.org/sites/default/files/styles/medium_1600x1000/public/thumbnails/images/daniela-kreimer.jpg?itok=R89tVtb4"
        ),
        Person(
            id: 3,
            name: "Manuel Juarez",
            profile_path:"https://static01.nyt.com/images/2017/06/09/universal/es/9mexicanoES6/9mexicanoES6-jumbo-v2.jpg"
        ),
        Person(
            id: 4,
            name: "Jose Angel",
            profile_path:"https://ath2.unileverservices.com/wp-content/uploads/sites/5/2018/02/acondicionador-de-cabello-para-hombre-e1517521713969-782x439.jpg"
        ),
        Person(
            id: 5,
            name: "Jose Manuel Martinez",
            profile_path:"https://significadodesonar.com/wp-content/uploads/2021/03/Sonar-con-Abuelo-Fallecido-300x194.jpg"
        ),
        Person(
            id: 6,
            name: "Sakura",
            profile_path:"https://i.imgur.com/gFf16hW.jpg"
        )
    ]
    
    static let Publicaciones = [
        
        Publicacion(
            id: 1,
            name: "Juan José Jaquez",
            description: "Hermosa casa nueva en venta en Tequisquiapan, construida en 2 plantas, estilo moderno.",
            price: 9,
            imageURL:"https://img-us-1.trovit.com/img1mx/SUNQ1R61vJ/SUNQ1R61vJ.1_11.jpg",
            profile_path:"https://ath2.unileverservices.com/wp-content/uploads/sites/5/2018/02/acondicionador-de-cabello-para-hombre-e1517521713969-782x439.jpg"
        ),
        Publicacion(
            id: 2,
            name: "Gonzalo Martines",
            description: "Casa habitación 2 pisos,  3 recámaras, sala, comedor, cocina 2 1/2 baños, terraza, cochera 2 carros,",
            price: 10,
            imageURL:"https://www.buscandocasa.com.mx/wordpress/wp-content/uploads/2017/08/departamento-tipo-b-coordenada-cumbres.jpg",
            profile_path:"https://elpagare.com.mx/wp-content/blogs.dir/3/files/2016/04/amex1.png"
        ),
        Publicacion(
            id: 3,
            name: "Manuel Juarez",
            description: "Tk-3733 La casa se construye prácticamente en un solo nivel.",
            price: 9,
            imageURL:"https://fundacioncompartir.org/sites/default/files/estos-son-algunos-de-los-edificios-construidos-en-madera.jpg",
            profile_path:"https://cdn.pixabay.com/photo/2020/07/05/07/14/business-man-5371914_960_720.jpg"
        ),
        Publicacion(
            id: 4,
            name: "Jose Angel",
            description: "Casa en venta en uno de los residenciales mas exitosos de la Riviera Veracruzana.",
            price: 9,
            imageURL:"https://i.ebayimg.com/images/g/70AAAOSwvD1iCzqU/s-l800.jpg",
            profile_path:"https://ath2.unileverservices.com/wp-content/uploads/sites/5/2018/02/acondicionador-de-cabello-para-hombre-e1517521713969-782x439.jpg"
        ),
        Publicacion(
            id: 5,
            name: "Jose Manuel Martinez",
            description: "El edificio se compone de 15 departamentos y 23 cajones de estacionamiento en una torre de 4 niveles. ",
            price: 3,
            imageURL:"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.lamudi.com.mx%2Fdistrito-federal%2Fterreno%2Ffor-sale%2F&psig=AOvVaw3EHlPqlMe-DfHNOFIPd-CP&ust=1645041708923000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPC7hojAgvYCFQAAAAAdAAAAABAD",
            profile_path:"https://ath2.unileverservices.com/wp-content/uploads/sites/5/2018/02/acondicionador-de-cabello-para-hombre-e1517521713969-782x439.jpg"
        ),
        Publicacion(
            id: 6,
            name: "Italian Salad",
            description: "Los Héroes León es un Fraccionamiento con excelente ubicación, cercano a rápidas vías de acceso y centros de trabajo en la zona norte de la ciudad. ",
            price: 5,
            imageURL:"https://i.ebayimg.com/images/g/IeUAAOSwxKFh1GyW/s-l800.jpg",
            profile_path:"https://ath2.unileverservices.com/wp-content/uploads/sites/5/2018/02/acondicionador-de-cabello-para-hombre-e1517521713969-782x439.jpg"
        )
    ]
    
    static let Mensajes = [
        
        Mensaje(
            id: 1,
            senderName: "Juan José Jaquez",
            description: "Hola Daniel, ¿como estas? ",
            profile_path:"https://ath2.unileverservices.com/wp-content/uploads/sites/5/2018/02/acondicionador-de-cabello-para-hombre-e1517521713969-782x439.jpg"
        ),
        Mensaje(
            id: 2,
            senderName: "Gonzalo Martines",
            description: "¿Aún estas interesado?",
            profile_path:"https://elpagare.com.mx/wp-content/blogs.dir/3/files/2016/04/amex1.png"
        ),
        Mensaje(
            id: 3,
            senderName: "Manuel Juarez",
            description: "Ok, te marco por la tarde",
            profile_path:"https://cdn.pixabay.com/photo/2020/07/05/07/14/business-man-5371914_960_720.jpg"
        ),
        Mensaje(
            id: 4,
            senderName: "Diana Almaraz",
            description: "Ya se vendio la propiedad",
            profile_path:"https://www.ashoka.org/sites/default/files/styles/medium_1600x1000/public/thumbnails/images/daniela-kreimer.jpg?itok=R89tVtb4"
        ),
        Mensaje(
            id: 5,
            senderName: "Jose Manuel Martinez",
            description: "Quedo a tus ordenes.",
            profile_path:"https://significadodesonar.com/wp-content/uploads/2021/03/Sonar-con-Abuelo-Fallecido-300x194.jpg"
        )
    ]
    
    static let Notificaciones = [
        
        Notificacion(
            id: 1,
            senderName: "Juan ha comentado tu publicación",
            description: "Estoy interesado en el producto que estas ofreciendo, ¿puedo ponerme en contacto via inbox?",
            profile_path:"https://ath2.unileverservices.com/wp-content/uploads/sites/5/2018/02/acondicionador-de-cabello-para-hombre-e1517521713969-782x439.jpg"
        ),
        Notificacion(
            id: 2,
            senderName: "Gonzalo te respondio",
            description: "Si esta disponible, puedes revisarlo en calle 13 de septiembre #18, los reales del Rio, josé maria morelos y pavon, estamos en contacto.",
            profile_path:"https://elpagare.com.mx/wp-content/blogs.dir/3/files/2016/04/amex1.png"
        ),
        Notificacion(
            id: 3,
            senderName: "Ha Manuel Juarez",
            description: "Le gusto tu publicación",
            profile_path:"https://cdn.pixabay.com/photo/2020/07/05/07/14/business-man-5371914_960_720.jpg"
        ),
        Notificacion(
            id: 4,
            senderName: "Diana Almaraz te respondio",
            description: "Si esta disponible, puedes revisarlo en calle 13 de septiembre #18, los reales del Rio, josé maria morelos y pavon, estamos en contacto.",
            profile_path:"https://www.ashoka.org/sites/default/files/styles/medium_1600x1000/public/thumbnails/images/daniela-kreimer.jpg?itok=R89tVtb4"
        ),
        Notificacion(
            id: 5,
            senderName: "Ha Jose Manuel Martinez",
            description: "Le gusto tu publicación",
            profile_path:"https://significadodesonar.com/wp-content/uploads/2021/03/Sonar-con-Abuelo-Fallecido-300x194.jpg"
        )
    ]
    static let Videos = [
        
        Video(
            id: 1,
            poster_path:"https://i.ytimg.com/vi/JkXTQyeNTxE/maxresdefault.jpg"
        ),
        Video(
            id: 2,
            poster_path:"https://i.ytimg.com/vi/El-_Wk7EAZs/maxresdefault.jpg"
        ),
        Video(
            id: 3,
            poster_path:"https://i.ytimg.com/vi/NvAAVaLoX1s/maxresdefault.jpg"
        ),
        Video(
            id: 4,
            poster_path:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQp3JTSjtYsBKrULeTTvE4-Zfw3p6X3NorXBA&usqp=CAU"
        ),
        Video(
            id: 5,
            poster_path:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYdlqdwSCKMC7K4JwJQbjdwnzxj_2r-CFZeg&usqp=CAU"
        ),
        Video(
            id: 6,
            poster_path:"https://i.ytimg.com/vi/hFRVcXsusA8/maxresdefault.jpg"
        )
    ]
}
