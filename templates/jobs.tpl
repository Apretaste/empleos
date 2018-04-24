<center>
<h1>Trabajos disponibles</h1>
</center>
{foreach item=item from=$jobs}
    <p>
    ${$item->salary} - Cierra en {$item->close_in_days} d&iacute;as - {$item->looking_for_profession} <br/>
    {link href="TRABAJOS TRABAJO {$item->id}" caption="{$item->title}"}<br/>
    </p>
{/foreach}

<p align="center">
    {button href="TRABAJOS INICIO" caption="INICIO"} &nbsp;

</p>
