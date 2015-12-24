Function Get-WhatTimeToStartCooking
    {
    Param
        (
        # The food you're cooking
        [Parameter(Mandatory=$True,Position=0)]
        [string]$FoodToBeCooked,
        
        # How long it needs to cook for in minutes
        [Parameter(Mandatory=$True,Position=1)]
        [int]$CookingTime,

        # Time you need this item to finish
        [Parameter(Mandatory=$false,Position=2)]
        [datetime]$DinnerTime = "17 October 2016"
        )
    $timeToStart = $DinnerTime.AddDays("-$($CookingTime)")
    write-Host "Start the $FoodToBeCooked at $timeToStart"
    $Object = New-Object System.Object
    $Object | Add-Member -type NoteProperty -name FoodToBeCooked -value $FoodToBeCooked 
    $Object | Add-Member -type NoteProperty -name CookingTime -value $CookingTime
    $Object | Add-Member -type NoteProperty -name StartAtTime -value $timeToStart
    Write-Output $Object
    }
    
$foodItems = @()

# cook & rest the three bird roast

[int]$birdCookTime = 95+30+30
$foodItems += (Get-WhatTimeToStartCooking -CookingTime $birdCookTime -FoodToBeCooked Bird)

# Roast the spuds
[int]$potatoRoast = 50+7
$potatoCooking = (Get-WhatTimeToStartCooking -CookingTime $potatoRoast -FoodToBeCooked Roasties)
$foodItems += $potatoCooking

# Get the Nut Roast done before the oven gets too hot

$foodItems += (Get-WhatTimeToStartCooking -CookingTime $potatoRoast -FoodToBeCooked "Nut Roast" -DinnerTime $potatoCooking.StartAtTime)

# Parsnips need a decent roasting

$foodItems += (Get-WhatTimeToStartCooking -CookingTime $potatoRoast -FoodToBeCooked Snips -DinnerTime "29 August 2016")




$foodItems | ft