<?php
function SetChat($conn, $accountID, $userID, $showNewChat = true)
{
    echo '<div class="card" style="border: 1px solid #ccc">';
    echo '<div class="ps-container ps-theme-default ps-active-y" id="chat-content" style="overflow-y: scroll !important; height:400px !important;">';

    $query = "SELECT * FROM messages WHERE accountID_FK = ? AND isDeleted = 0 ORDER BY dateCreated ASC";
    $result = PDO_PreparedSelect_Array($conn, $query, array($accountID));
    if($result)
    {
        $isToday = false;
        foreach($result as $row)
        {
            // check whether it's today
            if(DisplayDate($row['dateCreated']) == DisplayDate(date("now")))
            {
                if(!$isToday)
                {
                    echo '<div class="media media-meta-day">Today</div>';
                    $isToday = true;
                }
            }

            if($row['userID_FK'] == $userID)
            {
                echo '<div class="media media-chat">';
                echo '<img class="avatar" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">';
                
            }
            else
            {
                echo '<div class="media media-chat media-chat-reverse">';
            }

            echo '<div class="media-body">';

            if($row['isPicture'] == "1" || $row['isFile'] == "1")
            {
                if($row['isPicture'] == "1")
                {
                    $imgPath = PATH_Storage($accountID, 2).$row['message'];
                    echo "<img src='$imgPath' style='max-height:100px; max-width:200px'>";
                }
                else
                {
                    echo '<div class="media">';
                    echo '<i class="far fa-file-pdf fa-fw fa-2x text-info ml-0 pl-0"></i>';
                    echo '<div class="media-body">';
                    echo '<p class="mt-0">'.$row['message'].'</p>';
                    echo '</div>';
                    echo '</div>';
                }
            }
            else
            {
                echo utf8_decode($row['message']);
            }
            
            echo '<p class="meta"><time datetime="2018">'.DisplayDateTime($row['dateCreated']).'</time></p>';
            echo '</div>';

            echo '</div>';
        }
    }

    echo '<div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px;"><div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px;"><div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px;"></div></div></div>';

    if($showNewChat)
    {
        echo '<div class="publisher bt-1 border-light">';
        echo '<img class="avatar avatar-xs" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">';
        echo '<input name="newChatMessage" class="publisher-input" type="text" placeholder="Write something">';
        echo HTML_Button("newChat", '<i class="fa fa-paper-plane text-primary"></i>', "", false, "", false, false);
        echo '</div>';
    }
    echo '</div>';

    echo '<script>
    var objDiv = document.getElementById("chat-content");
    objDiv.scrollTop = objDiv.scrollHeight;
    </script>';
}

?>