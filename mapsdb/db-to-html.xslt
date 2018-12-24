<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="mapdb">
    <style>
      body {
        font-family: Arial,Helvetica,Sans-Serif;
        font-size: 10pt;
        background-color: black;
        color: #aeaedd;
      }

      img {
        max-width: 650px;
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

      .features {
        padding-bottom: 60px;
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
    <ul class="features">
      <li>
        Size: <xsl:value-of select="size/@x"/>&#xd7;<xsl:value-of select="size/@y" />
      </li>
      <li>
        Tileset: <xsl:value-of select="features/@tileset" />
      </li>
      <li>
        Players:
        <xsl:choose>
          <xsl:when test="features/@minPlayers = features/@maxPlayers">
            <xsl:value-of select="features/@minPlayers" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="features/@minPlayers" />
            -
            <xsl:value-of select="features/@maxPlayers" />
          </xsl:otherwise>
        </xsl:choose>
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

  <xsl:template match="authors" />

  <xsl:template match="games" />
</xsl:stylesheet>
