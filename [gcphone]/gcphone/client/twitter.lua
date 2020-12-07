RegisterNetEvent("gcPhone:twitter_getTweets1333")
AddEventHandler("gcPhone:twitter_getTweets1333",function(tweets)
	SendNUIMessage({ event = 'twitter_tweets', tweets = tweets })
end)

RegisterNetEvent("gcPhone:twitter_getFavoriteTweets1333")
AddEventHandler("gcPhone:twitter_getFavoriteTweets1333",function(tweets)
	SendNUIMessage({ event = 'twitter_favoritetweets', tweets = tweets })
end)

RegisterNetEvent("gcPhone:twitter_newTweets1333")
AddEventHandler("gcPhone:twitter_newTweets1333",function(tweet)
	SendNUIMessage({ event = 'twitter_newTweet', tweet = tweet })
end)

RegisterNetEvent("gcPhone:twitter_updateTweetLikes1333")
AddEventHandler("gcPhone:twitter_updateTweetLikes1333",function(tweetId,likes)
	SendNUIMessage({ event = 'twitter_updateTweetLikes', tweetId = tweetId, likes = likes })
end)

RegisterNetEvent("gcPhone:twitter_setAccount1333")
AddEventHandler("gcPhone:twitter_setAccount1333",function(username,password,avatarUrl)
	SendNUIMessage({ event = 'twitter_setAccount', username = username, password = password, avatarUrl = avatarUrl })
end)

RegisterNetEvent("gcPhone:twitter_createAccount1333")
AddEventHandler("gcPhone:twitter_createAccount1333",function(account)
	SendNUIMessage({ event = 'twitter_createAccount', account = account })
end)

RegisterNetEvent("gcPhone:twitter_setTweetLikes1333")
AddEventHandler("gcPhone:twitter_setTweetLikes1333",function(tweetId,isLikes)
	SendNUIMessage({ event = 'twitter_setTweetLikes', tweetId = tweetId, isLikes = isLikes })
end)

RegisterNUICallback('twitter_login',function(data, cb)
	TriggerServerEvent('gcPhone:twitter_login1333',data.username,data.password)
end)

RegisterNUICallback('twitter_changePassword',function(data,cb)
	TriggerServerEvent('gcPhone:twitter_changePassword1333',data.username,data.password,data.newPassword)
end)

RegisterNUICallback('twitter_createAccount',function(data,cb)
	TriggerServerEvent('gcPhone:twitter_createAccount1333',data.username,data.password,data.avatarUrl)
end)

RegisterNUICallback('twitter_getTweets',function(data,cb)
	TriggerServerEvent('gcPhone:twitter_getTweets1333',data.username,data.password)
end)

RegisterNUICallback('twitter_getFavoriteTweets',function(data,cb)
	TriggerServerEvent('gcPhone:twitter_getFavoriteTweets1333',data.username,data.password)
end)

RegisterNUICallback('twitter_postTweet',function(data,cb)
	TriggerServerEvent('gcPhone:twitter_postTweets1333',data.username or '', data.password or '',data.message)
end)

RegisterNUICallback('twitter_toggleLikeTweet',function(data,cb)
	TriggerServerEvent('gcPhone:twitter_toogleLikeTweet1333',data.username or '', data.password or '',data.tweetId)
end)

RegisterNUICallback('twitter_setAvatarUrl',function(data,cb)
	TriggerServerEvent('gcPhone:twitter_setAvatarUrl1333',data.username or '',data.password or '',data.avatarUrl)
end)