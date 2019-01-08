<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="mapdb">
    <style>
      body {
        font-family: Arial,Helvetica,Sans-Serif;
        background-color: black;
        color: #aeaedd;
      }

      img {
        width: 650px;
      }

      .content {
        width: 650px;
        margin: auto;
      }

      .map {
        position: relative;
        padding-bottom: 60px;
      }
      
      .no-preview {
        width: 650px;
        height: 650px;
      }
      
      .map:nth-child(5n+0) .no-preview {
        background-color: darkgreen;
      }
      
      .map:nth-child(5n+1) .no-preview {
        background-color: brown;
      }
      
      .map:nth-child(5n+2) .no-preview {
        background-color: darkslateblue;
      }

      .map:nth-child(5n+3) .no-preview {
        background-color: darkmagenta;
      }

      .map:nth-child(5n+4) .no-preview {
        background-color: darkorchid;
      }

      .map-text {
        position: absolute;
        top: 20px;
        left: 20px;
        right: 20px;
        text-shadow: 0 3px 5px black, 3px 0 5px black, 0 -3px 5px black, -3px 0 5px black;

        visibility:hidden;
        opacity:0;
        transition:visibility 0.3s linear,opacity 0.3s linear;
      }
      
      .map:hover .map-text {
        visibility:visible;
        opacity:1;
      }
    </style>

    <div class="content">
      <xsl:apply-templates select="@* | node()"/>
    </div>
  </xsl:template>

  <xsl:template match="title">
    <h1>
      <xsl:value-of select="name"/>
    </h1>
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
      <xsl:choose>
        <xsl:when test="preview">
          <img alt="Map Preview">
            <xsl:attribute name="src">
              <xsl:value-of select="preview" />
            </xsl:attribute>
          </img>
        </xsl:when>
        <xsl:otherwise>
          <div class="no-preview"></div>
        </xsl:otherwise>
      </xsl:choose>

      <div class="map-text">
        <xsl:apply-templates select="title" />
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
          <xsl:if test="release">
            <li>
              Release date: <xsl:value-of select="release" />
            </li>
          </xsl:if>
        </ul>

        <xsl:apply-templates select="downloads" />
      </div>
    </div>
  </xsl:template>

  <xsl:template match="authors" />

  <xsl:template match="games" />
</xsl:stylesheet>
