pragma Singleton

import QtQuick 2.0

QtObject {
    property Gradient gradientBackground: Gradient {
        GradientStop {
            position: 0.1875
            color: "#8e8575"
        }

        GradientStop {
            position: 0.9575
            color: "#000000"
        }
    }

    property Gradient testBackground: Gradient {
            GradientStop {
                position: 0.1875
                color: "green"
            }

            GradientStop {
                position: 0.9575
                color: "blue"
            }
        }
}
