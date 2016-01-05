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

   
$taskTemplate = Get-Content -Path .\TaskTemplate.xml -Raw
$allocationTemplate = Get-Content -Path .\AllocationTemplate.xml -Raw


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

# serve & eat starter

$foodItems += (Get-WhatTimeToStartCooking -CookingTime 10 -FoodToBeCooked Salmon -DinnerTime "07 September 2016")


# Sides

$foodItems += (Get-WhatTimeToStartCooking -CookingTime 6 -FoodToBeCooked Beans)
$foodItems += (Get-WhatTimeToStartCooking -CookingTime 24 -FoodToBeCooked Garnish)
$foodItems += (Get-WhatTimeToStartCooking -CookingTime 40 -FoodToBeCooked CauliCheese)
$foodItems += (Get-WhatTimeToStartCooking -CookingTime 25 -FoodToBeCooked Yorkies -DinnerTime "25 October 2016")
$foodItems += (Get-WhatTimeToStartCooking -CookingTime 15 -FoodToBeCooked SproutsFirstWay)
$foodItems += (Get-WhatTimeToStartCooking -CookingTime 25 -FoodToBeCooked SproutsSecondWay -DinnerTime "11 October 2016")


#Appetisers
$apps = @()
[datetime]$GuestsArrive = "23 May 2016"
$Apps += (Get-WhatTimeToStartCooking -CookingTime 10 -FoodToBeCooked "Pork Rind" -DinnerTime $GuestsArrive)
$Apps += (Get-WhatTimeToStartCooking -CookingTime 17 -FoodToBeCooked "Cheese & Brie things" -DinnerTime $GuestsArrive.AddDays("10"))
$Apps += (Get-WhatTimeToStartCooking -CookingTime 20 -FoodToBeCooked "Venison Pigs in blankets" -DinnerTime $GuestsArrive.AddDays("10"))





$foodItems | ft
$Apps | Ft
