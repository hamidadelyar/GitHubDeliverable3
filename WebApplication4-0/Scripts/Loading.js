$(document).ready(function () {
    hideLoader();
});
function showLoader()
{
    $('.greyOut').show();
}
function hideLoader()
{
    $('.greyOut').hide();
}
function shrink() {
    $('.greyOut img').animate({
        height: '5px',
        width: '5px',
        padding: '32.5px'
    },
    {
        duration: 1500,
        easing: 'swing',
        complete: function () {
            if (showing) {
                grow()
            }
            else {
                finAnim()
            }
        }
    });
}
function grow() {
    $('.greyOut img').animate({
        height: '70px',
        width: '70px',
        padding: '0px'
    },
    {
        duration: 1500,
        easing: 'swing',
        complete: function () {
            if (showing) {
                shrink()
            }
            else {
                finAnim()
            }
        }
    });
}
function finAnim() {
    $('.greyOut img').css('height', '70px');
    $('.greyOut img').css('width', '70px');
    $('.greyOut img').css('padding', '0px');
}