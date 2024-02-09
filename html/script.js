$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
        $("#img").attr("src",item.gun);
        switch (item.gun){
            case 'weapon_bat':
                $("#jquerytitle").text("Bat: 5000$");
                break;
            case 'weapon_bottle':
                $("#jquerytitle").text("bottle: 5000$");
                break;
            case 'weapon_crowbar':
                $("#jquerytitle").text("crowbar: 5000$");
                break;
            case 'weapon_knife':
                $("#jquerytitle").text("knife: 5000$");
                break;
            case 'weapon_knuckle':
                $("#jquerytitle").text("knuckle: 5000$");
                break;
            case 'weapon_machete':
                $("#jquerytitle").text("machete: 5000$");
                break;
            case 'weapon_snspistol':
                $("#jquerytitle").text("snspistol: 5000$");
                break;
            case 'weapon_snspistol_mk2':
                $("#jquerytitle").text("snspistol_mk2: 5000$");
                break;
            case 'weapon_switchblade':
                $("#jquerytitle").text("switchblade: 5000$");
                break;
            case 'rifle_ammo':
                $("#jquerytitle").text("Rifle Ammo: 5000$");
                break;
            case 'pistol_ammo':
                $("#jquerytitle").text("Pistol Ammo: 5000$");
                break;
            default:
                break;
        }
    })

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post("https://zebpatcheco/exit", JSON.stringify({}));
            return
        }
    };

    $("#a").click(function(){
        $.post("https://zebpatcheco/main",JSON.stringify({
            text:"a",
        }));
        display(false)
        return;
    })
})