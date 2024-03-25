import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Make transition")

    function checkIntersection(circle, rectangle) {
        var circleCenterX = circle.x + circle.width / 2 +40;
        var circleCenterY = circle.y + circle.height / 2 +40;
        var rectLeft = rectangle.x;
        var rectRight = rectangle.x + rectangle.width;
        var rectTop = rectangle.y;
        var rectBottom = rectangle.y + rectangle.height;

        var horizontalIntersection = circleCenterX >= rectLeft && circleCenterX <= rectRight;
        var verticalIntersection = circleCenterY >= rectTop && circleCenterY <= rectBottom;

        return horizontalIntersection && verticalIntersection;
    }

    Rectangle {
        id: scene
        anchors.fill: parent

        Rectangle {
            id: leftRectangle
            x: 100
            y: 200
            color: "lightgrey"
            width: 100
            height: 100
            border.color: "black"
            border.width: 3
            radius: 5

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ball.x += 20;
                    if (ball.x >= leftRectangle.x && checkIntersection(ball, rightRectangle)) {
                        ballAnimation.running = true;
                    }
                }
            }
        }
        Rectangle {
            id: rightRectangle
            x: 300
            y: 200
            color: "lightgrey"
            width: 100
            height: 100
            border.color: "black"
            border.width: 3
            radius: 5

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ballAnimation.running = true;
                }
            }
        }

        Rectangle {
            id: ball
            color: "darkgreen"
            x: leftRectangle.x + 5
            y: leftRectangle.y + 5
            width: leftRectangle.width - 10
            height: leftRectangle.height - 10
            radius: width / 2
        }

        SequentialAnimation {
            id: ballAnimation
            NumberAnimation {
                target: ball
                property: "x"
                to: leftRectangle.x + 5
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: ball
                property: "y"
                to: leftRectangle.y + 5
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    }
}
