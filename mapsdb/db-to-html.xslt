<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="mapdb">
    <style>
      body {
        background-color: black;
        color: #aeaedd;
      }

      .content {
        width: 650px;
        margin: auto;
      }

      .row {
        overflow: hidden;
      }

      .release-date {
        color: white;
        margin-bottom: 10px;
        font-weight: bold;
        float: left;
      }

      .view-map {
        float: right;
      }

      .view-map, .view-map:visited, .view-map:hover, .view-map:active {
        color: inherit;
      }
    </style>

    <div class="content">
      <xsl:apply-templates select="@* | node()"/>
    </div>
  </xsl:template>

  <xsl:template match="title">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="logo"/>
      </xsl:attribute>
      <xsl:attribute name="alt">
        <xsl:value-of select="name"/>
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template match="map">
    <xsl:apply-templates select="title" />
    <div class="row">
      <div class="release-date">
        <xsl:value-of select="release" />
      </div>
      <a class="view-map" target="_blank">
        <xsl:attribute name="href">
          <xsl:value-of select="preview" />
        </xsl:attribute>
        View Map
      </a>
    </div>
    <div>
      <xsl:value-of select="title/description" />
    </div>
    <ul>
      <li>
        Size: <xsl:value-of select="size/@x"/>&#xd7;<xsl:value-of select="size/@y" />
      </li>
      <li>
        Tileset: <xsl:value-of select="features/@tileset" />
      </li>
      <li>
        Players: <xsl:value-of select="features/@players" />
      </li>
      <xsl:if test="features/@teams">
        <li>
          Teams: <xsl:value-of select="features/@teams" />
        </li>
      </xsl:if>
      <xsl:if test="features/@useMapSettings='true'">
        <li>
          Use map settings
        </li>
      </xsl:if>
      <xsl:if test="features/@island='true'">
        <li>
          Island map
        </li>
      </xsl:if>
    </ul>
  </xsl:template>
</xsl:stylesheet>
