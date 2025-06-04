# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
ContentTag.destroy_all
Note.destroy_all
Answer.destroy_all
Question.destroy_all
Content.destroy_all
Tag.destroy_all
User.destroy_all

user = User.create!(
    email: "julien.dupont@example.com",
    password: "password",
    nickname: "Julien",
)

content = Content.create!(
    name: "VIVRE A BALI COMBIEN ÇA COUTE ?",
    url: "https://www.youtube.com/watch?v=sZX9YEJrrok",
    source_type: "video",
    language: "fr",
    duration: 804,
    transcription: " Tu rêves d'aller à Bali, ou même pas du tout ? Je t'invite quand même à regarder ce vlog pour découvrir combien ça coûte de vivre ici. Dans cette vidéo, on te montrera pourquoi on a choisi la région de Canggu, à quoi ressemblent nos journées ici, et combien ça coûte. À la fin, je te dirai aussi ce que tu n'aimeras pas ici.
Bienvenue sur L’Odyssée, c’est Sy et Lanelo. On est des voyageurs spécialisés dans les astuces et conseils, et on essaie de devenir digital nomade. À la fin de la vidéo, on vous propose un guide pour investir à Bali. C’est parti !
Pourquoi avoir choisi Canggu ? On a déjà réalisé une vidéo sur ce sujet, je vous invite à la voir juste après celle-ci. Globalement, on sortait d’un tour du monde de 2 ans, nos derniers continents visités étaient l’Afrique et l’Europe, et on ne rencontrait absolument personne. On s’est dit qu’on allait aller dans un endroit où on pouvait rencontrer du monde, et Bali est venu naturellement à l’esprit.
Ensuite, tout simplement, le monde du digital nomadisme est assez nouveau pour nous. Avant, on était juste des voyageurs. Il fallait un endroit où faire tout ça facilement. En France, la mentalité pour créer quelque chose est assez difficile, car tout le monde n’a pas l’habitude. Ici, tout le monde fait ça, donc parler avec des gens qui ont l’habitude rend tout plus facile et très motivant.
Pour vous installer à Bali, il y a quatre points essentiels.
D’abord, la communauté et le networking, il n’y a pas mieux.
Ensuite, la facilité de vie : tout est développé pour avoir ce que vous voulez où vous voulez.
Le troisième point, c’est la connexion internet, qui est très bonne sur la plupart des spots de l’île, surtout à Canggu, car la majorité travaille sur internet.
Enfin, le quatrième point, ce sont les logements de très bonne qualité, surtout à Canggu. Que ce soit des guesthouses ou des villas, vous trouverez tout ce que vous voulez, y compris du très haut standing. Par exemple, nous avons une cuisine partagée, une piscine, un lit double et un espace de travail dans la chambre, ce qui suffit largement et est très confortable. En plus, on est à 10 minutes de la plage et à 40 minutes d’Ubud quand il n’y a pas de trafic.
Alors, que signifie être très bien placé à Canggu ? Zoomons un peu pour comprendre comment se loger ici.
La première zone est le centre de Canggu (en rouge). Si vous voulez rester plusieurs mois, on vous conseille d’éviter cette zone, qui est plutôt réservée aux touristes ou aux premières visites.
Les autres zones sont plus tranquilles, avec moins de développement et de constructions. Par exemple, la zone verte, Pererenan, est plus calme que sa voisine et vous y trouverez de très belles villas.
La zone bleue, North Canggu, est très tranquille car plus loin de la plage.
La zone jaune, Berawa, est déjà développée mais beaucoup moins populaire que sa voisine.
Enfin, pour ceux qui veulent vraiment plus de tranquillité mais à 25-30 minutes du centre, il y a la zone violette de Seseh. Voilà, vous avez l’embarras du choix.
À quoi ressemblent nos journées ici ? On commence par un petit déjeuner maison, puis on profite du logement. Soit on travaille à l’intérieur, soit on se relaxe à la piscine. C’est un peu de temps pour soi.
Le midi, on mange plutôt dans des warungs, des restaurants locaux avec des spécialités locales, et c’est vraiment très bon. Pour nous, c’est une des meilleures cuisines d’Asie du Sud-Est. Il y a vraiment de tout. Pour ceux qui sont végan ou végétariens, vous aurez largement le choix, ce qui est important par rapport à d’autres pays d’Asie où la viande est omniprésente.
Vous trouverez aussi des restaurants italiens, japonais ou méditerranéens, mais ça coûte beaucoup plus cher. Avec notre petit budget, on préfère manger local.
L’après-midi, soit on reste à la maison, soit on va dans un café avec une bonne wifi et un bon thé glacé pour travailler dans de bonnes conditions. Une fois le travail terminé, on va se relaxer, par exemple en prenant une noix de coco sur la plage ou dans les rizières, ce qui permet de bien finir la journée.
Le soir, on a deux options : manger avec des amis ou faire du sport. On ne fait pas les deux en même temps, mais on n’oublie jamais la petite glace qui fait toujours du bien, que ce soit après le sport ou avec des amis.
Maintenant, la partie que vous attendiez tous : combien ça coûte ? Plus précisément, combien ça coûte à Canggu ? À la fin, on vous donnera notre budget mensuel, sachant qu’on est sur un très petit budget, surtout à Canggu.
Le premier poste de dépense est le logement. Pour les petits budgets, vous pouviez trouver à partir de 5 millions de roupies, mais maintenant c’est plutôt autour de 6 à 7 voire 8 millions selon le niveau de privacité. Nous, on a trouvé un logement à 6 millions. Si vous voulez une villa, il n’y a rien en dessous de 12 millions, il faudra compter plutôt autour de 25 millions. C’est une grosse somme.
Pour la nourriture, c’est très facile ici. Vous pouvez commander ou cuisiner si vous avez une cuisine partagée. Au restaurant, le minimum local est à partir de 15 000 roupies, mais la moyenne est plutôt autour de 40 000. Après ça devient cher à partir de 80 000, comme une pizza italienne à 180 000, le plus cher qu’on a fait en 6 mois.
Pour le forfait téléphone, le réseau qui marche super bien est celui de Telkomsel, celui à prendre dès l’arrivée. La carte SIM est valable 3 mois si vous n’avez pas enregistré votre téléphone à l’aéroport. Vous avez droit à trois cartes SIM différentes par an sans enregistrement, soit 9 mois. Si vous comptez rester plus longtemps, il faudra enregistrer votre téléphone.
Le sport est assez cher à Bali, surtout à Canggu. Par exemple, la salle la plus locale qu’on a trouvée coûte environ 30 € par mois, sans climatisation et avec un espace limité. Il y a aussi des salles plus développées avec sauna, jacuzzi, bain froid, comme la salle Wonderlust ou Obsidian, qui sont des prestations haut de gamme.
Concernant le visa, le coût est supérieur à celui des autres pays d’Asie du Sud-Est. Le visa de base coûte environ 33 € par mois, extensible un mois pour environ le double du prix. Le visa de 2 mois coûte environ 20 € de plus mais vous évite les démarches fréquentes. On a pris le visa B211 pour rester 6 mois, qui est extensible deux fois. Il coûte plus cher mais c’est plus tranquille. On passe par une agence pour éviter les complications et on paie un peu plus, mais on a moins de soucis.
Pour le transport, il est difficile de vivre ici sans scooter. On l’a loué à Ubud 800 000 roupies, mais à Canggu c’est plus cher, autour de 1 million par mois.
Parlons maintenant des points négatifs. À Canggu, il y a du bruit et beaucoup de trafic de motos et voitures, les rues sont étroites. Il faut éviter certaines zones aux heures de pointe, sinon vous ne progresserez pas, même en moto, car ça bloque. C’est parfois insupportable, même si ça reste correct globalement.
Il y a deux saisons à Bali, chacune avec ses inconvénients : la saison des pluies, où il y a peu de monde et où on est au calme, et la saison sèche touristique, plus fréquentée mais où les expatriés partent en été. En fonction de la saison, vous aurez des bons et mauvais côtés.
Un autre point négatif, surtout à Canggu, c’est le développement rapide qui fait un peu perdre le côté authentique de Bali. Il y a plus de constructions que de temples ou forêts, même si ces derniers sont encore présents ailleurs sur l’île.
On arrive à la fin, alors Sandy, la reine des finances, combien ça nous coûte par mois à deux ?
Environ 975 €, soit environ 400 € par personne. On divise certains coûts comme le logement ou le scooter, et on fait attention. Beaucoup n’ont pas notre budget, on vit très simplement. En général, comptez environ 1500 € pour vivre correctement à Bali. Plus vous mettez, plus vous vivez comme un roi.
Quelles sont les autres options pour vivre à Bali ? Nous sommes à Canggu, mais vous avez aussi Uluwatu, en fort développement, plus axé sur le surf que le digital nomadisme, avec des prix assez élevés.
Ubud est bien placée au centre de l’île, proche de tout, mais sans la mer. C’est plus spirituel, orienté yoga.
Amed est plus tranquille, village de pêcheurs parfait pour les fans de plongée, mais avec une connexion internet moins bonne, donc moins adapté aux digital nomades. Il y a une grosse communauté francophone.
Sanur, près de l’aéroport, est plus urbain mais avec des loyers plus bas, et proche des îles Lombok, Gili, ou Nusa Penida.
Enfin, si vous êtes intéressé pour investir à Bali, on propose en description un ebook pour éviter les fraudes et gagner du temps et de l’argent.
Si vous avez aimé la vidéo, n’hésitez pas à laisser un like, un commentaire, ou vous abonner avec la petite cloche pour ne rien manquer.
Ciao !",
    summary: "Analyse détaillée du coût de la vie à Bali, incluant logement, alimentation, transport et loisirs.",
    thumbnail: "https://img.youtube.com/vi/sZX9YEJrrok/hqdefault.jpg",
    user: user
)


questions = Question.create!([
    {
        statement: "Quel est le principal avantage de choisir Canggu à Bali pour un digital nomade ?",
        answer_true: "La communauté active et le networking facilités.",
        answer_1: "La proximité des temples historiques.",
        answer_2: "Les prix très bas du logement en centre-ville.",
        answer_3: "L'absence totale de trafic et de bruit.",
        explanation: "Canggu est choisi surtout pour sa communauté dynamique et son réseau de digital nomades, ce qui facilite le travail collaboratif et l'intégration.",
        content_id: content.id
    },
    {
        statement: "Quel est le budget mensuel moyen pour vivre à Canggu à deux, selon la vidéo ?",
        answer_true: "Environ 975 € par mois pour deux personnes.",
        answer_1: "1500 € par personne par mois.",
        answer_2: "Environ 500 € par mois pour deux personnes.",
        answer_3: "Plus de 2000 € par mois pour deux personnes.",
        explanation: "Le couple de la vidéo vit avec un budget serré de 975 € par mois pour deux, en privilégiant les logements partagés et la nourriture locale.",
        content_id: content.id
    },
    {
        statement: "Quels sont les types de logement que l’on peut trouver à Canggu ?",
        answer_true: "De la guesthouse basique à la villa de très haut standing.",
        answer_1: "Seulement des appartements partagés sans piscine.",
        answer_2: "Uniquement des villas luxueuses hors de prix.",
        answer_3: "Des hôtels 5 étoiles uniquement.",
        explanation: "Canggu propose un large éventail de logements adaptés à tous les budgets, des petites chambres partagées aux villas avec piscine et cuisine équipée.",
        content_id: content.id
    },
    {
        statement: "Quelle est la difficulté majeure liée au transport à Canggu mentionnée dans la vidéo ?",
        answer_true: "Le trafic dense et les rues étroites provoquant des embouteillages, notamment en heures de pointe.",
        answer_1: "Le manque total de scooters à louer.",
        answer_2: "L'absence de routes goudronnées.",
        answer_3: "Le prix très élevé des transports en commun.",
        explanation: "Le trafic à Canggu peut être très dense, avec beaucoup de motos et voitures, ce qui rend les déplacements parfois longs et stressants.",
        content_id: content.id
    },
    {
        statement: "Quelle saison à Bali est recommandée pour éviter la foule, selon la vidéo ?",
        answer_true: "La saison des pluies, car il y a beaucoup moins de touristes tout en ayant un temps correct.",
        answer_1: "La saison sèche, car il n’y a aucune pluie et pas de touristes.",
        answer_2: "L’hiver européen, pour profiter du climat tempéré.",
        answer_3: "L’été, car c’est la haute saison touristique.",
        explanation: "La saison des pluies à Bali correspond à une période plus calme en termes de tourisme, bien que des averses soient possibles, ce qui permet de profiter d’un Bali plus tranquille.",
        content_id: content.id
    }
])

tags = Tag.create!([
    { name: "Bali" },
    { name: "Digital nomad" },
    { name: "Coût de la vie" },
])
ContentTag.create!([
    { content_id: content.id, tag_id: tags[0].id },
    { content_id: content.id, tag_id: tags[1].id },
    { content_id: content.id, tag_id: tags[2].id },
])

Note.create!([
    {
        user_id: user.id,
        content_id: content.id,
        description: "Le visa B211 semble le plus pratique pour rester 6 mois à Bali sans trop de démarches répétées."
    },
    {
        user_id: user.id,
        content_id: content.id,
        description: "À éviter : centre de Canggu pour du long terme à cause du bruit et des touristes. Préférer Pererenan ou North Canggu."
    },
])

user = User.create!(
    email: "nomade@example.com",
    password: "motdepasse123",
    nickname: "NomadeDigital"
)

content = Content.create!(
    name: "Un psychiatre analyse des scènes de films",
    url: "https://www.youtube.com/watch?v=3jstrH6isCs",
    source_type: "video",
    language: "fr",
    duration: 657,
    transcription: "Dans la plupart des films et des séries qui mettent en scène un psychopathe, il y a cette association au génie, à une forme de supériorité. On peut être psychopathe et génie, mais c’est un hasard. Bonjour, je suis Christophe Debien, médecin psychiatre spécialisé dans la prévention du suicide.
Les psychopathes, on dit souvent qu’ils n’ont pas d’empathie. C’est faux. L’empathie, c’est la capacité de se projeter dans la tête de l’autre. Sans empathie, ils ne pourraient pas manipuler aussi bien. Ce qu’ils ont, c’est une empathie froide : ils comprennent les autres, mais ils se fichent de leurs émotions. Ils n’ont pas d’empathie chaude. C’est ce qui permet, dans les films, de justifier leur capacité à tuer sans état d’âme.
J’ai travaillé en prison pendant neuf ans, face à de nombreux délinquants, dont certains avaient tué. Tous disaient que c’était difficile de mettre à mort quelqu’un. Ce qui permet à une personnalité dite psychopathique de le faire, c’est l’absence de cette « éponge émotive ». Je dirais donc que sur cette représentation, on est à 80 % science contre 20 % fiction.
La bipolarité est une maladie de l’humeur. On oscille entre gaieté et tristesse, mais dans des limites socialement admissibles. Le problème, c’est la notion de « norme ». Les patients bipolaires reprochent souvent qu’on les juge selon ces normes, surtout en phase maniaque. Une phase maniaque, c’est très joyeux, très euphorique, contrairement à la phase dépressive.
En réalité, les patients bipolaires ont souvent beaucoup plus de phases dépressives que maniaques. Les accès maniaques sont rares, mais marquants. Certains se retrouvent à donner de l’argent nus dans la rue, ou à acheter trois Porsche dans la même journée. Ce qu’on voit aussi dans ces phases, c’est la tachypsychie : les pensées vont très vite, à un rythme intérieur qui peut être 10, 100 ou 1 000 fois supérieur à la normale. Cela provoque un épuisement psychique et physique, avec absence de sommeil, d’alimentation, etc.
Dans la scène évoquée, il lui propose des anxiolytiques. Mais ce n’est pas ce qu’il faut : elle a besoin d’un thymorégulateur, qui régule l’humeur. Pour cette représentation, je donnerais 98 % science contre 2 % fiction, à cause de l'erreur sur le traitement.
Les troubles dissociatifs de l’identité sont encore très discutés dans la communauté scientifique. Certains pensent que ça existe, d’autres non. À l’origine, il y a un cas rapporté par une psychiatre, celui de Sybil. Mais cette description était isolée, donc peu scientifique.
Je ne donnerais pas 0 % à Split, parce qu’il y a débat. Je mettrais 20 %, surtout pour le côté personnalité psychopathique ou sociopathique.
Dans Un homme d’exception, on montre bien une forme de psychose : la schizophrénie paranoïde. Le personnage voit des liens là où il n’y en a pas. C’est un symptôme positif, c’est-à-dire une perception ou une pensée qui s’ajoute à la normale, sans être un « pouvoir ». Les hallucinations y sont matérialisées par des personnages, ce qui illustre bien le syndrome d’influence : des injonctions du type « Tue-le » ou « Tue-toi ». Ces hallucinations sont souvent auto-agressives.
Ce qu’on retrouve le plus souvent dans la schizophrénie, ce sont les hallucinations acoustico-verbales : des sons, des bribes de mots, parfois des musiques. Rien de très élaboré. Le film montre qu’on peut avoir une vie pleine malgré la maladie, sans être un tueur. C’est important. Mais la représentation est un peu caricaturale : je donnerais 40 % science contre 60 % fiction.
La scène de Rambo montre bien un symptôme caractéristique du stress post-traumatique : la reviviscence. Le personnage revit complètement la scène traumatique. Il y a des situations « gâchettes » qui déclenchent ce retour en arrière. Ce n’est pas de la violence volontaire, mais une décharge de ce qui est remonté, y compris l’adrénaline du passé. Je donnerais 70 % science, car c’est bien vu, avec les connaissances de l’époque.
La scène des électrochocs dans Vol au-dessus d’un nid de coucou est à la fois très exacte et très fausse. Exacte sur la technique (mise de conducteur, objet dans la bouche), mais fausse parce que cela se fait sous anesthésie générale aujourd’hui. Cette scène fait beaucoup de mal à la psychiatrie moderne. Je donnerais 50/50.
Dans Les Soprano, la représentation de la dépression est très intéressante. Tony Soprano, chef mafieux, souffre de dépression. Cela casse le tabou de la faiblesse. Il parle aussi du lithium, un traitement. Il dit qu’il ne ressent plus rien. C’est réaliste. Douleur physique et douleur psychique activent les mêmes zones cérébrales : pour le cerveau, elles sont équivalentes.
On voit aussi le ralentissement psychomoteur, les idées suicidaires… Je pense que cette série est un vrai livre ouvert sur la dépression. Je lui donne 100 % science.",
    summary: "Analyse la représentation des troubles psychiatriques dans les oeuvres de fiction.",
    thumbnail: "https://img.youtube.com/vi/3jstrH6isCs/maxresdefault.jpg",
    user: user
)

Question.create!([
    {
        statement: "Quelle est la principale erreur dans le traitement proposé à un personnage en phase maniaque selon le Dr Debien ?",
        answer_true: "Lui prescrire des anxiolytiques au lieu d’un thymorégulateur",
        answer_1: "Lui administrer des électrochocs sous anesthésie",
        answer_2: "Lui donner un traitement contre la dépression",
        answer_3: "Lui proposer une thérapie comportementale",
        explanation: "Le Dr Christophe Debien précise qu’un personnage en phase maniaque n’a pas besoin d’anxiolytiques, mais d’un thymorégulateur, un médicament qui régule l’humeur. Les anxiolytiques sont inadaptés car ils ne traitent pas le fond du trouble bipolaire.",
        content_id: content.id
    },
    {
        statement: "Quelle est la forme d’empathie dont disposent les psychopathes selon le Dr Debien ?",
        answer_true: "Une empathie froide : ils comprennent les autres mais se fichent de leurs émotions",
        answer_1: "Une absence totale d’empathie",
        answer_2: "Une empathie chaude : ils ressentent les émotions des autres profondément",
        answer_3: "Une empathie uniquement pour eux-mêmes",
        explanation: "Le Dr Debien explique que les psychopathes ont une empathie froide, ce qui leur permet de manipuler les autres sans être affectés par leurs émotions. Ils ne manquent pas d’empathie cognitive mais n’ont pas d’empathie affective.",
        content_id: content.id
    },
    {
        statement: "Quel symptôme est illustré dans 'Un homme d’exception' par la schizophrénie paranoïde ?",
        answer_true: "Le syndrome d’influence avec des hallucinations qui poussent à l’auto-agression",
        answer_1: "La tachypsychie avec accélération des pensées",
        answer_2: "La reviviscence du stress post-traumatique",
        answer_3: "Les phases maniaques de la bipolarité",
        explanation: "'Un homme d’exception' montre bien le syndrome d’influence, un symptôme positif de la schizophrénie paranoïde, où des hallucinations verbales donnent des injonctions souvent auto-agressives.",
        content_id: content.id
    },
    {
        statement: "Quelle est la caractéristique principale du stress post-traumatique illustrée dans la scène de Rambo ?",
        answer_true: "La reviviscence, ou retour complet à la scène traumatique déclenché par des situations 'gâchettes'",
        answer_1: "L’absence d’empathie envers soi-même",
        answer_2: "La phase maniaque avec euphorie extrême",
        answer_3: "Les hallucinations auditives et visuelles",
        explanation: "La scène de Rambo illustre la reviviscence, un symptôme clé du stress post-traumatique où le personnage revit intensément son traumatisme face à certains déclencheurs.",
        content_id: content.id
    }
])

Tag.create!([
    { name: "Psychiatrie" },
    { name: "Cinéma" },
    { name: "Troubles mentaux" }
])

ContentTag.create!([
    { content: content, tag: Tag.find_by!(name: "Psychiatrie") },
    { content: content, tag: Tag.find_by!(name: "Cinéma") },
    { content: content, tag: Tag.find_by!(name: "Troubles mentaux") }
])

puts "Creating users..."
user1 = User.create!(
  nickname: "Alice",
  avatar: "https://res.cloudinary.com/demo/image/upload/c_fill,h_300,w_400/r4irpddfursvlpypkyrl.jpg",
  password: "password123",
  email: "alice@gmail.com"
)

user2 = User.create!(
  nickname: "Bob",
  avatar: "https://res.cloudinary.com/demo/image/upload/c_fill,h_300,w_400/cld-sample.jpg",
  password: "password123",
  email: "bob@gmail.com"
)

puts "Creating tags..."
tag1 = Tag.create!(name: "Ruby")
tag2 = Tag.create!(name: "Rails")
tag3 = Tag.create!(name: "IA")
puts "Creating content..."

content1 = Content.create!(
    user: user1,
    transcription: "Ruby on Rails, souvent appelé Rails, est un framework web côté serveur écrit en Ruby. Il permet de développer rapidement des applications web en suivant le modèle MVC (Modèle-Vue-Contrôleur). Rails facilite la gestion des bases de données, les routes, ainsi que les vues HTML. Ce framework est apprécié pour sa convention plutôt que configuration, ce qui simplifie grandement le processus de développement. Enfin, il dispose d’une large communauté et de nombreuses bibliothèques, appelées gems, pour étendre ses fonctionnalités.",
    source_type: "video",
    url: "https://www.youtube.com/watch?v=ncmRnnjI7_E&t=681s",
    thumbnail: "https://img.youtube.com/vi/ncmRnnjI7_E/maxresdefault.jpg",
    name: "Rails tutorial",
    duration: "15:30",
    language: "en",
    summary: "A complete beginner guide to Rails"
)

content2 = Content.create!(
    user: user2,
    transcription: "L’intelligence artificielle, ou IA, désigne la capacité d’une machine à imiter des fonctions cognitives humaines telles que l’apprentissage, le raisonnement et la résolution de problèmes. Elle regroupe différents domaines comme le machine learning, le traitement du langage naturel, et la vision par ordinateur. L’IA est utilisée dans de nombreux secteurs, de la santé à la finance, pour automatiser des tâches complexes. Son objectif est de créer des systèmes capables de prendre des décisions intelligentes et d’améliorer leur performance avec l’expérience. La recherche en IA continue d’évoluer rapidement, posant aussi des questions éthiques importantes.",
    source_type: "article",
    url: "https://www.youtube.com/watch?v=uGUXlN2Quyc",
    thumbnail: "https://img.youtube.com/vi/uGUXlN2Quyc/maxresdefault.jpg",
    name: "Intro to AI",
    duration: "8:45",
    language: "fr",
    summary: "Introduction à l’intelligence artificielle"
)

puts "Linking tags to content..."
ContentTag.create!(content: content1, tag: tag1)
ContentTag.create!(content: content1, tag: tag2)
ContentTag.create!(content: content2, tag: tag3)
puts "Creating notes..."
Note.create!(description: "Rails utilise le modèle MVC pour organiser le code et faciliter le développement.", user: user1, content_id: content1.id)
Note.create!(description: "L’IA englobe plusieurs sous-domaines dont le machine learning et le traitement du langage naturel.", user: user2, content_id: content2.id)
puts "Creating questions..."
question1 = Question.create!(
    content: content1,
    statement: "Quel modèle architectural est principalement utilisé dans Ruby on Rails pour organiser une application web ?",
    answer_true: "Modèle-Vue-Contrôleur (MVC)",
    answer_1: "Modèle-View-Presenter (MVP)",
    answer_2: "Flux unidirectionnel",
    answer_3: "Architecture microservices",
    explanation: "Ruby on Rails suit le modèle MVC qui sépare la logique métier, la présentation et les données."
)
question2 = Question.create!(
    content: content2,
    statement: "Quels sont certains des domaines couverts par l’intelligence artificielle ?",
    answer_true: "Machine learning, traitement du langage naturel, vision par ordinateur",
    answer_1: "Développement web et bases de données",
    answer_2: "Cryptographie et sécurité réseau",
    answer_3: "Stockage en cloud et virtualisation",
    explanation: "L’IA comprend plusieurs domaines comme le machine learning et la vision par ordinateur, permettant aux machines d’imiter des fonctions humaines."
)
puts "Creating answers..."
Answer.create!(user: user1, question: question1, result: true)
Answer.create!(user: user2, question: question1, result: false)
Answer.create!(user: user2, question: question2, result: true)
puts ":coche_blanche: Done seeding!"
