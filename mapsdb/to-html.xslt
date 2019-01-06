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

      .map {
        padding-bottom: 60px;
      }
    </style>

    <div class="content">
      <xsl:apply-templates select="@* | node()"/>
    </div>
  </xsl:template>

  <xsl:template match="title">
    <xsl:choose>
      <xsl:when test="logo">
        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="logo"/>
          </xsl:attribute>
          <xsl:attribute name="alt">
            <xsl:value-of select="name"/>
          </xsl:attribute>
        </img>
      </xsl:when>
      <xsl:otherwise>
        <h2>
          <xsl:value-of select="name"/>
        </h2>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="downloads">
    <xsl:for-each select="full">
      <div>
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="text()" />
          </xsl:attribute>

          <xsl:choose>
            <xsl:when test="@name">
              <xsl:value-of select="@name" />
            </xsl:when>
            <xsl:otherwise>
              Download
              <xsl:value-of select="../../title/name" />
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
    </xsl:for-each>

    <!-- TODO: other download types -->
  </xsl:template>

  <xsl:template match="map">
    <div class="map">
      <xsl:apply-templates select="title" />
      <div class="row">
        <div class="release-date">
          <xsl:value-of select="release" />
        </div>

        <xsl:if test="preview">
          <a class="view-map" target="_blank">
            <xsl:attribute name="href">
              <xsl:value-of select="preview" />
            </xsl:attribute>
            View Map
          </a>
        </xsl:if>
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
        <xsl:if test="features/@ladder='true'">
          <li>
            Official Ladder Map
          </li>
        </xsl:if>
        <li>
          Game:
          <xsl:choose>
            <xsl:when test="game/@versionId">
              <xsl:value-of select="//versions/version[@id=current()/game/@versionId]/title/name" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="//games/game[@id=current()/game/@gameId]/title/name" />
            </xsl:otherwise>
          </xsl:choose>
        </li>
        <li>
          Author: <xsl:value-of select="//authors/author[@id=current()/author/@authorId]/title/name" />
        </li>
      </ul>

      <xsl:apply-templates select="downloads" />
    </div>
  </xsl:template>

  <xsl:template match="authors" />

  <xsl:template match="games" />
</xsl:stylesheet>
