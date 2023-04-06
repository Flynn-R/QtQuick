function figure(index, r) {
    var coords
    if (index === 0) {
        coords = [
            [49 * r / 40, 27 * r / 40],
            [2 * r, 27 * r / 40],
            [11 * r / 8, 9 * r / 8],
            [13 * r / 8, 37 * r / 20],
            [r, 7 * r / 5],
            [3 * r / 8, 37 * r / 20],
            [5 * r / 8, 9 * r / 8],
            [0, 27 * r / 40],
            [31 * r / 40, 27 * r / 40]
        ]
    }
    else if (index === 2) {
        coords = [
            [
                [r, 6 * r / 5],
                [4 * r / 5, 6 * r / 5],
                [4 * r / 5, 4 * r / 5],
                [6 * r / 5, 4 * r / 5],
                [6 * r / 5, 6 * r / 5],
                [r, 6 * r / 5]
            ],

            [
                [0, 3 * r / 5],
                [r, 0],
                [2 * r, 3 * r / 5],
                [2 * r / 5, 3 * r / 5],
                [2 * r / 5, 2 * r],
                [8 * r / 5, 2 * r],
                [8 * r / 5, 3 * r / 5]
            ]
        ]
    }
    else if (index === 3) {
        coords = [
                    [20, 20],
                    [0.2 * (r - 20), 0.3 * (r - 20)],
                    [0.4 * (r - 20), 0.4 * (r - 20)],
                    [0.5 * (r - 20), 0.5 * (r - 20)],
                    [0.4 * (r - 20), 0.6 * (r - 20)],
                    [0.2 * (r - 20), 0.7 * (r - 20)],
                    [20, r - 20],   // 6
                    [r - 20, r - 20],
                    [0.8 * (r - 20), 0.7 * (r - 20)],
                    [0.6 * (r - 20), 0.6 * (r - 20)],
                    [0.5 * (r - 20), 0.5 * (r - 20)],
                    [0.6 * (r - 20), 0.4 * (r - 20)],
                    [0.8 * (r - 20), 0.3 * (r - 20)],
                    [r - 20, 20],   // 13
                    [20, 20]
                ]
    }

    return coords
}
