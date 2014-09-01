# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#PostSetting.create! :posts_per_page => 10, :allow_comments => true

#Country.find_by_id_or_create 

# User.find_or_create_by_email(first_name:'EuroHackTrip', last_name:'Admin', email:'admin@eurohacktrip.org', password:'inclusion.14', country:'Kenya', city:'Nairobi', about:'xyz', interest:'xyz', is_admin:true) # find_or_create_by_email will only try to create user if email doesn't exist
# User.find_or_create_by_email(first_name:'EuroHackTrip', last_name:'Test', email:'test@eurohacktrip.org', password:'test', country:'Kenya', city:'Nairobi', about:'xyz', interest:'xyz') # find_or_create_by_email will only try to create user if email doesn't exist

Country.create([
{
name: 'Germany',
flag: '',
map: '',
# avatar: '/system/countries/avatars/000/000/001/original/germany.jpg',
show_in_nav: true,
description: 'Germany has the world\'s fourth-largest economy by nominal GDP and the fifth-largest by purchasing power parity. As a global leader in several industrial and technological sectors, it is the second-largest exporter and third-largest importer of goods. It is a developed country with a very high standard of living, featuring comprehensive social security that includes the world\'s oldest universal health care system. Known for its rich cultural and political history, Germany has been the home of many influential philosophers, music composers, scientists, and inventors. http://en.wikipedia.org/wiki/Germany'
},
{
name: 'Netherlands',
flag: '',
map: '',
# avatar: '/system/countries/avatars/000/000/002/original/netherlands.jpg',
show_in_nav: true,
description: 'The Netherlands had the tenth-highest per capita income in the world in 2011. The country is host to the Organisation for the Prohibition of Chemical Weapons and five international courts: the Permanent Court of Arbitration, the International Court of Justice, the International Criminal Tribunal for the Former Yugoslavia, the International Criminal Court and the Special Tribunal for Lebanon. This has led to the city being dubbed "the world\'s legal capital". The Netherlands has a market-based mixed economy, ranking 17th of 177 countries according to the Index of Economic Freedom. In May 2011, the Netherlands was ranked as the "happiest" country according to results published by the OECD http://en.wikipedia.org/wiki/Netherlands'
},
{
name: 'France',
flag: '',
map: '',
# avatar: '/system/countries/avatars/000/000/003/original/france.jpg',
show_in_nav: true,
description: 'France is a developed country and has the world\'s fifth-largest economy by nominal GDP and seventh-largest by purchasing power parity. In terms of total household wealth, France is the wealthiest nation in Europe and fourth in the world. French citizens enjoy a high standard of living, with the country performing well in international rankings of education, health care, life expectancy, civil liberties, and human development. http://en.wikipedia.org/wiki/France'
},
{
name: 'Switzerland',
flag: '',
map: '',
# avatar: '/system/countries/avatars/000/000/004/original/switzerland.jpg',
show_in_nav: true,
description: 'Switzerland has the highest wealth per adult (financial and non-financial assets) in the world according to Credit Suisse and eighth-highest per capita gross domestic product on the IMF list. Swiss citizens have the second-highest life expectancy in the world on UN and WHO lists. http://en.wikipedia.org/wiki/Switzerland'
}
])

City.create([
{
	name:'Berlin',
	country_id:1,
	year:2014,
	dates:'1st-7th October',
	# photo: '/system/cities/photos/000/000/001/original/berlin.jpg', 
	theme:'Electronic Engineering',
	icon:'fa-cogs',
	description:'Berlin is “a magnet for worldwide entrepreneurs and investors”, like Alexander Ljung and Edial Dekker of Gidsy. Berlin even “feels like a startup itself”.  ... Berlin has a healthy mix of early stage and late stage startups ...  Office space is cheap in Berlin.
	
	http://www.whiteboardmag.com/european-startup-hubs-compared-tel-aviv-london-paris-moscow-berlin/
	
	For years, Germany’s capital city has been an arty enclave with little or no industry. But now its startup scene is pushing hard, with a host of trendy startups and young entrepreneurs drawn in by low rents, an attractive lifestyle and easy access to Eastern European tech talent.
	
	Areas of specialty:
	
	The city’s dominant tech force remain the three Samwer brothers, who built their empire by cloning American e-commerce businesses.The city is proving strong on digital media, social games and the quirky end of the consumer web.
	
	Major funding sources:
	
	The angel network is still small, but international and European investors are increasingly drawn to Berlin, and some local VCs like Earlybird have shifted focus here from other German regions. Meanwhile, the Samwers’ Rocket Internet empire is happy to fund aggressive businesses in proven markets.
	
	Top startups:
	
	Zalando, Wooga, Soundcloud, Eyeem, Gidsy, DeliveryHero
	
	http://gigaom.com/2012/10/15/europetechhubs/'
},
{
	name:'Amsterdam',
	country_id:2,
	year:2014,
	dates:'8th-15th October',
	# photo: '/system/cities/photos/000/000/004/original/amsterdam.jpg', 
	theme:'E-Learning',
	icon:'fa-book',
	description:'A rash of small startups have suddenly appeared, with small teams of developers building a wide range of apps and services.
	
	Areas of specialty:
	
	Varied, but particularly strong around services for creative industries like video, publishing and advertising.
	
	Major funding sources:
	
	The number of accelerators, and VC and angel investors is expanding.
	
	Top startups:
	
	Layar, Adyen, Silk, WeTransfer
	
	Notable exits:
	
	Soocial, Quova
	
	http://gigaom.com/2012/10/15/europetechhubs/'
},
{
	name:'Paris',
	country_id:3,
	year:2014,
	dates:'16th-23rd October',
	# photo: '/system/cities/photos/000/000/004/original/paris.jpg', 
	theme:'Financial Inclusion',
	icon:'fa-money',
	description:'Many investors think Paris has seen its best days, not least because the insular environment and punative tax regime send many entrepreneurs packing. But when startups work here, they go big.
	
	Areas of specialty:
	
	Media, advertising, and e-commerce are strong, particularly in the segments where French brands can draw on the national obsession with haute-couture and luxury. Wireless is seeing some inventive activity too.
	
	Major funding sources:
	
	There are some large venture companies, often tied to local telcos or software companies, but local investments tend to be inwardly focused.
	
	Top startups:
	
	Criteo, DailyMotion, Deezer, Viadeo
	
	http://gigaom.com/2012/10/15/europetechhubs/'
},
{
	name:'Zurich',
	country_id:4,
	year:2014,
	dates:'24th-31st October',
	# photo: '/system/cities/photos/000/000/004/original/zurich.jpg', 
	theme:'Social Entrepreneurship',
	icon:'fa-globe',
	description:'A lot of big technology companies have set up shop here. Google has set up its European engineering headquarters in Zurich, and Yahoo moved its European headquarters there from London last year. There is peripherals maker, Logitech, and even a few large, non-IT tech companies, like Tyco. They find there a plentiful supply of engineering minds, many of whom graduated from Switzerland’s equivalent of MIT, the ETH.
	
	http://gigaom.com/2009/04/04/is-switzerland-the-newest-tech-hub/
	
	Zurich now counts more than 60 technology parks and several venture funds. Swiss Start-up Monitor records 388 current startups in Zurich. http://www.wallstreetandtech.com/it-infrastructure/new-global-tech-hubs-emerge-in-surprisin/240142973'
},
{
	name:'Helsinki',
	country_id:5,
	year:2014,
	dates:'8th-15th October',
	# photo: '/system/cities/photos/000/000/005/original/helsinki.jpg', 
	theme:'E-Learning',
	icon:'fa-book',
	description:'"They come to us and they say to us \'show us how to take over the world\'," a VC said over a beer in Helsinki. In the office of cleantech startup ZenRobotics, a meeting room bears the name \'world domination\'.

Rovio, which unleashed the Angry Birds franchise on the world in 2009, is inescapable. From the airport to the Helsinki\'s biggest department store, Angry Birds toys, games, and other tie-ins are everywhere.

First Slush in 2008, participants were a few hundred, and in 2003, 5,000 including investors, companies, and Finland\'s prime minister Jyrki Katainen. In 2014 its expected to hit 10,000. The aim of the two-day event is to get a critical mass of investors together in the region, according to Koskinen.

Nokia’s loss may just end up being Finland’s gain. As the mobile giant slowly implodes, it is releasing batches of smart, skillful entrepreneurs into the local economy and allowing them to build interesting companies. http://goo.gl/JAFpYe

Areas of specialty:
Mobile is at the heart of most new businesses here, but there’s also a substantial gaming industry led by Rovio.

Major funding sources:
Many former Nokians are funding each other’s business ideas, and the region has good access to VC networks across Scandinavia and the Baltics too.

Top startups:
Rovio, Jolla, Kiosked, Steam Republic

Notable exits:
Innobase, Jaiku

http://gigaom.com/2012/10/15/europetechhubs/

'
}
# 60.17080000000000, 24.93750000000000
])
