#!/bin/bash

echo ""
echo "Applying migration GuidanceExample"

echo "Adding routes to conf/app.routes"
echo "" >> ../conf/app.routes
echo "GET        /guidanceExample                       controllers.GuidanceExampleController.onPageLoad()" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "guidanceExample.title = guidanceExample" >> ../conf/messages.en
echo "guidanceExample.heading = guidanceExample" >> ../conf/messages.en

echo "Migration GuidanceExample completed"
