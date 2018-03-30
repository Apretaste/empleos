<h1>Mis trabajos publicados</h1>

<table cellspacing="0" cellpadding="10" border="0" width="100%">
    {foreach item=job from=$jobs}
    <tr>
        <td>{$job->title}. {link href="TRABAJOS TRABAJO {$job->id}" caption="[editar]"}</td>
    </tr>
    {/foreach}
</table>

{button href="TRABAJOS AGREGAR" popup="true" caption="&#x2795;" desc="t:T&iacute;tulo*"}</td>